import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phiz/constants/constant.dart';
import 'package:phiz/constants/validation_constant.dart';
import 'package:phiz/controller/form_validation_controller.dart';
import 'package:phiz/controller/user_auth_controlller.dart';
import 'package:phiz/view/auth_screens/forget_password_screen.dart';
import 'package:phiz/view/auth_screens/signup_screen.dart';
import 'package:phiz/widgets/common_widget.dart';

class LoginScreen extends StatelessWidget{
  final FormValidationController _formValidationController = Get.put(FormValidationController());
  final  UserAuthController _userAuthController = Get.put(UserAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 90.w,vertical: 50.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonButton(
                color: blueColor,
                buttonName: "LOGIN",
                onTap: (){
                  _formValidationController.loginFormKey.currentState
                      .save();
                  if (_formValidationController.loginFormKey.currentState
                      .validate()) {
                    _userAuthController.signInThroughEmailAndPass();
                  } else {
                    Get.snackbar("SignUp Screen",
                        "Please Fill All The Fields",
                        duration: Duration(seconds: 5));
                  }
                }
            ),
            SizedBox(height: 30.h,),

            // -- -- ==== sign up button ==== -- --
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonText(title: "Don't have an account!"),
                SizedBox(width: 25.w,),
                InkWell(
                    onTap: (){
                      Get.to(() => SignUpScreen());
                    },
                    child: commonText(title: "Sign Up", color: blueColor,fontWidget: FontWeight.w600)),
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
                  SizedBox(height: 40.h,),

                  // -- -- ==== title ==== -- --
                  commonText(title: "Welcome To Phiz...!",color: blueColor,fontSize: 65.sp, fontWidget: FontWeight.bold),

                  SizedBox(
                    height: 100.h,
                  ),

                  // -- -- ==== Form ==== -- --
                  Form(
                      key: _formValidationController.loginFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          children: [
                            commonTextFormField(
                              hintText: "Email",
                              prefixIcon: Icon(CupertinoIcons.mail,),
                              controller: _formValidationController.emailController,
                              validator: ValidationConstant.emailValidator,

                            ),
                            SizedBox(height: 40.h,),
                            commonTextFormField(
                                hintText: "Password",
                                controller: _formValidationController.passwordController,
                                prefixIcon: Icon(CupertinoIcons.lock,),
                                validator: ValidationConstant.passwordValidatorForSignIn,
                                obscureText: true
                            ),
                            SizedBox(height: 20.h,),

                            // -- -- ==== forget password button ==== -- --
                            InkWell(
                              onTap: (){
                                Get.to(() => ForgetPasswordScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  commonText(title: "Forget Password    ", color: blueColor,)
                                ],),
                            )
                          ],),
                      )),
                  SizedBox(height: 30.h,),
                ],)
          ),
        ),
      ),
    );
  }
}