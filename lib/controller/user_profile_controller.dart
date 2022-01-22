import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:phiz/model/user_profile_model.dart';

class UserProfileController extends GetxController {

  UserProfileModel userProfileModel = UserProfileModel();

  TextEditingController usernameProfileController = new TextEditingController();
  TextEditingController emailProfileController = new TextEditingController();
  TextEditingController phoneNumberProfileController = new TextEditingController();

  File imageFile;
  String fileName;

  // ------- to get user data -------
  Future getUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    try {
      DocumentSnapshot _doc = await FirebaseFirestore.instance.collection(
          'users').doc(currentUser.uid).get();
      // ------ ===== condition to check the data is get  or not =====  ------
      _doc != null ? print("Get Data from firebase") : print("Get null Data from firebase");

      userProfileModel = UserProfileModel.fromDocumentSnapshot(_doc);
      usernameProfileController.text = userProfileModel.username;
      emailProfileController.text = userProfileModel.email;
      phoneNumberProfileController.text = userProfileModel.phoneNumber;

      update();
    }
    catch (error) {
      print(error);
    }
  }

  //  ---------------- get the image from gallery ---------------------
  void getImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    imageFile = File(img.path);
    update();
  }

  //  ---------------- function to update data with image ---------------------
  Future updateDataOfProfile() async {

    if (imageFile != null) {
      String imageUrl;
      fileName = basename(imageFile.path);
      final currentUser = FirebaseAuth.instance.currentUser;
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
          'user_images/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() =>
          () {
        print("Upload Complete");
      });

      imageUrl = await firebaseStorageRef.getDownloadURL();
      String fireStoreUserImage = userProfileModel.image;

      await FirebaseFirestore.instance.collection('users').doc(currentUser.uid)
          .update(
          {
            "uid": currentUser.uid,
            "email": emailProfileController.text,
            "image": imageUrl != null ? imageUrl : fireStoreUserImage,
            "phoneNumber": phoneNumberProfileController.text,
            "username": usernameProfileController.text,
            // "cart": userProfileModel.cart.toList()
          }
      )
          .then((_) => print("Data Updated"))
          .catchError((onError) => print(onError.toString()));
      await getUserData();
      Get.back();
      Get.snackbar("Profile Screen", "Profile Updated Successfully",duration: Duration(seconds: 3), colorText: Colors.white);
    }
    else {
      final currentUser = FirebaseAuth.instance.currentUser;
      String fireStoreUserImage = userProfileModel.image;
      FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update(
          {
            "uid": currentUser.uid,
            "email": emailProfileController.text,
            "image": fireStoreUserImage,
            "phoneNumber": phoneNumberProfileController.text,
            "username": usernameProfileController.text,
            // "cart": userProfileModel.cart.toList()
          }
      )
          .then((_) => print("Data Updated"))
          .catchError((onError) => print(onError.toString()));
      await getUserData();
      Get.back();
      Get.snackbar("Profile Screen", "Profile Updated Successfully",duration: Duration(seconds: 3),colorText: Colors.white);
    }
  }
}