import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phiz/controller/user_profile_controller.dart';
import 'package:phiz/model/user_profile_model.dart';
import 'package:phiz/view/auth_screens/login_screen.dart';
import 'package:phiz/view/main_app_screens/bottom_navigation_bar_screen.dart';
import 'form_validation_controller.dart';

class UserAuthController extends GetxController {

  FirebaseAuth auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  Rx<User> firebaseUser;
  Rx<UserProfileModel> userModel = UserProfileModel().obs;

  @override
  void onInit() {
    super.onInit();

    // userModel.bindStream(listenToUser());
  }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User user) {

    if (user == null) {
      // Get.off(() => LoginScreen());
    } else {
      userModel.bindStream(listenToUser());
      print(auth.currentUser.uid);
      print("Data Is Bind to user Model");
      // Get.off(() => BottomNavigationBarScreen());
    }
  }

  // ==============================================================================
  // -------------- ===========    Sign up through email & password   ========== --------------
  //         =========================================================================

  Future createAccount() async {
    final FormValidationController _formValidationController = Get.put(
        FormValidationController());

    try {
      User firebaseUser = (await auth.createUserWithEmailAndPassword(
          email: _formValidationController.emailController.text.trim(),
          password: _formValidationController.passwordController.text.trim()))
          .user;
      firebaseUser.sendEmailVerification();

      if (firebaseUser != null) {
        // -- here we add user data to Firestore --
        CollectionReference user = FirebaseFirestore.instance.collection(
            'users');
        user.doc(firebaseUser.uid).set({
          "uid": firebaseUser.uid,
          "email": _formValidationController.emailController.text,
          "username": _formValidationController.usernameController.text,
          "image": "",
          "phoneNumber": _formValidationController.phoneNumberController.text,
          "cart": []

        }).then((_) => print("Data Of User Is Added to Firestore "))
            .catchError((onError) => print(onError.toString()));

        _formValidationController.clearTextField();
        Get.back();

        Get.snackbar(
          "Create Account Notification",
          "You Created Account Successfully, Please Verify Your Email Before Login ",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
        // return _user;
      } else {
        Get.snackbar(
          "Create Account Notification",
          "Account creation field!  please check your email or password",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          "Create Account Notification",
          "The password provided is too weak.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          "Create Account Notification",
          "The Account Already Exists For That Email.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      }
    } catch (error) {
      print(error);
      // Get.snackbar(
      //   "Add Employee Notification",
      //   error.toString(),
      //   snackPosition: SnackPosition.TOP,
      //   duration: Duration(seconds: 5),
      // );
      return null;
    }
  }

// ==============================================================================
// -------------- ===========    Sign In through email and password    ========== --------------
//         =========================================================================

  Future signInThroughEmailAndPass() async {
    final FormValidationController _formValidationController = Get.put(FormValidationController());
    final UserProfileController userProfileController = Get.put(UserProfileController());

    try {
      User _user = (await auth.signInWithEmailAndPassword(
          email: _formValidationController.emailController.text.trim(),
          password: _formValidationController.passwordController.text.trim()))
          .user;
      if (_user.emailVerified) {
        // ----- to get user profile data -----
        await userProfileController.getUserData();

        _formValidationController.clearTextField();

        Get.off(() => BottomNavigationBarScreen());

        Get.snackbar(
          "Sign In Notification",
          "You are successfully Sign In",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      } else {
        Get.snackbar(
          "Sign In Notification",
          "Your account is not verified. We are sending you verification email please verify your account to login Thanks",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );

        // ------ === Send Email Verification === ------
        _user.sendEmailVerification();
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Sign In Notification",
          "No user found for that email.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Sign In Notification",
          "Wrong password provided for that user.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  // ==============================================================================
// -------------- ===========    Forget Password Method    ========== ----------------------
//         =========================================================================
//
  Future resetPasswordRequest() async {
    final FormValidationController _formValidationController = Get.put(
        FormValidationController());

    try {
      await auth.sendPasswordResetEmail(
          email: _formValidationController.emailController.text.trim());
      Get.snackbar("Reset Password Screen",
          "The mail is send to ${_formValidationController.emailController.text
              .trim()} please reset the Password",
          duration: Duration(seconds: 5));
      _formValidationController.clearTextField();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Reset Password Notification",
          "No user found for that email.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      } else {
        return null;
      }
    } catch (error) {
      // Get.snackbar("Reset Password Screen", error.toString(),
      //     duration: Duration(seconds: 5));
      print(error);
    }
  }


// ==============================================================================
  // -------------- ===========    Sign out method   ========== --------------
  //         =========================================================================

  void logOut() async {
    FirebaseAuth.instance.signOut();
    Get.offAll(() => LoginScreen());
  }

  // ==============================================================================
// -------------- ===========    Update User Data method   ========== --------------
//         =========================================================================

  updateUserData(Map<String, dynamic> data) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .update(data);
  }

// ==============================================================================
// -------------- ===========    Get User Data method   ========== --------------
//         =========================================================================

  Stream<UserProfileModel> listenToUser() => FirebaseFirestore.instance
      .collection("users")
      .doc(auth.currentUser.uid)
      .snapshots()
      .map((snapshot) => UserProfileModel.fromDocumentSnapshot(snapshot));


}
