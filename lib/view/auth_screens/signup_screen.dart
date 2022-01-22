import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phiz/constants/constant.dart';
import 'package:phiz/constants/validation_constant.dart';
import 'package:phiz/controller/form_validation_controller.dart';
import 'package:phiz/controller/user_auth_controlller.dart';
import 'package:phiz/widgets/common_widget.dart';

class SignUpScreen extends StatelessWidget{
  final FormValidationController formValidationController = Get.put(FormValidationController());
  final UserAuthController _userAuthController = Get.put(UserAuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: 90.w,vertical: 50.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonButton(
                color: blueColor,
                buttonName: "SignUp",
                onTap: () {
                    formValidationController.signupFormKey.currentState
                        .save();
                    if (formValidationController.signupFormKey.currentState
                        .validate()) {
                      _userAuthController.createAccount();
                    } else {
                      Get.snackbar("SignUp Screen",
                          "Please Fill All The Fields",
                          duration: Duration(seconds: 5));
                    }
                  }
                ),
            SizedBox(height: 30.h,),

            // -- -- ==== sign in button ==== -- --
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonText(title: "Already have an account!"),
                SizedBox(width: 25.w,),
                InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: commonText(title: "Sign In", color: blueColor,fontWidget: FontWeight.w600)),
              ],),
          ],
        ),
      ),

      // ----- body ------
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 50.w),
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),

                  // -- -- ==== title ==== -- --
                  commonText(title: "Sign Up...!",color: blueColor,fontSize: 65.sp, fontWidget: FontWeight.bold),
                  SizedBox(
                    height: 110.h,
                  ),

                  // -- -- ==== title ==== -- --
                  Form(
                      key: formValidationController.signupFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          children: [
                            commonTextFormField(
                              hintText: "Username",
                              prefixIcon: Icon(CupertinoIcons.person,),
                              controller: formValidationController.usernameController,
                              validator: ValidationConstant.commonValidator,
                            ),
                            SizedBox(height: 30.h,),
                            commonTextFormField(
                              hintText: "Email",
                              prefixIcon: Icon(CupertinoIcons.mail,),
                              controller: formValidationController.emailController,
                              validator: ValidationConstant.emailValidator,
                            ),
                            SizedBox(height: 30.h,),
                            commonTextFormField(
                              hintText: "Phone Number",
                              prefixIcon: Icon(CupertinoIcons.device_phone_portrait,),
                              controller: formValidationController.phoneNumberController,
                              validator: ValidationConstant.commonValidator,
                            ),
                            SizedBox(height: 30.h,),
                            commonTextFormField(
                                hintText: "Password",
                                controller: formValidationController.passwordController,
                                prefixIcon: Icon(CupertinoIcons.lock,),
                                validator: ValidationConstant.passwordValidatorForSignIn,
                                obscureText: true
                            ),
                            // SizedBox(height: 540.h,),
                          ],),
                      )),
                ],)
          ),
        ),
      ),
    );
  }
}