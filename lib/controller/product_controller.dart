import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phiz/model/product_model.dart';

class ProductController extends GetxController{

  //     ---- ================ product Model Instance =============== -----

  RxList<ProductModel> productDataList = RxList<ProductModel>([]);

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("product");

  //   ----- ========== Global Key ========== -----
  final GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();


  TextEditingController nameController, imageUrlController, priceController;

  TextEditingController nameProductUpdateController = new TextEditingController();
  TextEditingController imageUrlProductUpdateController = new TextEditingController();
  TextEditingController priceProductUpdateController = new TextEditingController();


  File imageFile;
  String fileName;


  // ---------- onInit() ------------

  @override
  void onInit(){
    super.onInit();

    productDataList.bindStream(getAllProductData());

    nameController = TextEditingController();
    imageUrlController = TextEditingController();
    priceController = TextEditingController();

  }

  //  ---------------- get the image from gallery ---------------------
  void getImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    imageFile = File(img.path);
    update();
  }

  void clearTextField(){
    nameController.clear();
    imageUrlController.clear();
    priceController.clear();
  }
  // ==============================================================================
  // -------------- ===========    Add product data to Firestore    ========== --------------
  //         =========================================================================

  Future addProduct() async{

    successMsg(){
      Get.snackbar(
        "Add Product Notification",
        "Successfully Added the Product",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
    }

    try {

      String imageUrl;
      fileName = basename(imageFile.path);

      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('product_image/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => () {print("Upload Complete");});

      imageUrl = await firebaseStorageRef.getDownloadURL();

      final addProduct = FirebaseFirestore.instance.collection("product").doc();
      await addProduct.set({
        "id": addProduct.id,
        "name": nameController.text,
        "imageUrl": imageUrl != null ? imageUrl : "",
        "price":  priceController.text,

      }).then((_) => successMsg()).catchError((onError) => print(onError.toString()));

      clearTextField();

    }
    catch (error){
      Get.snackbar(
        "Add Product Notification",
       "Check Your Internet Connection",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
  }

  // ==============================================================================
  // -------------- ===========    Get the product data from Firestore    ========== --------------
  //         =========================================================================


  Stream<List<ProductModel>> getAllProductData() => collectionReference.snapshots().map((query) =>
      query.docs.map((item) => ProductModel.fromDocumentSnapshot(item)).toList());

}