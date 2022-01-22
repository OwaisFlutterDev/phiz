import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FormValidationController extends GetxController{

  //   ----- ========== Global Key ========== -----
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();


  //   ----- ========== Text Editing Controller ========== -----
  TextEditingController usernameController, emailController, passwordController, phoneNumberController;

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumberController = TextEditingController();

  }

  void clearTextField(){
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneNumberController.clear();
  }

}