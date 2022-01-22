import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phiz/constants/constant.dart';
import 'package:phiz/controller/user_auth_controlller.dart';
import 'package:phiz/controller/user_profile_controller.dart';
import 'package:phiz/widgets/profile_screen_widgets.dart';

class ProfileScreen extends StatelessWidget {
  final UserAuthController userAuthController = Get.put(UserAuthController());
  final UserProfileController userProfileController = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 40.w,vertical: 50.h),
          child: userProfileDataWidget(
              onTap: () {
                userAuthController.logOut();
              },
              textData: "Sign Out",
              iconData: Icon(
                CupertinoIcons.arrowshape_turn_up_left_2,
                color: Colors.black,
              )),
        ),
        // resizeToAvoidBottomInset: false,
        body: GetBuilder<UserProfileController>(
            init: UserProfileController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // --- for design --
                    Container(
                      height: 600.h,
                      width: Get.size.width,
                      decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(80.r),
                              bottomRight: Radius.circular(80.r))),
                      // --  edit icon and image --
                      child: Column(
                        children: [
                          SizedBox(
                            height: 70.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 43.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("User Profile",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 50.sp,
                                            color: Colors.white))),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return GetBuilder<UserProfileController>(
                                                      init: UserProfileController(),
                                                      builder: (controller) {
                                                        return buildAlertDialogForUpdate(controller);
                                                      });
                                                });
                                          },
                                          child: SingleChildScrollView(
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: 65.r,
                                              ))),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 65.h,
                          ),
                          Container(
                            height: 320.h,
                            width: 320.r,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade800,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(userProfileController.userProfileModel.image),
                                    fit: BoxFit.cover)),
                          ),
                        ],
                      ),
                    ),
                    // ------ user personal data ------
                    SizedBox(
                      height: 90.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.w),
                      child: Column(
                        children: [
                          userProfileDataWidget(
                              textData: userProfileController.userProfileModel.username,
                              iconData: Icon(
                                CupertinoIcons.person_alt,
                                color: Colors.black,
                              )),
                          SizedBox(
                            height: 50.h,
                          ),
                          userProfileDataWidget(
                              textData: userProfileController.userProfileModel.email,
                              iconData: Icon(
                                CupertinoIcons.mail,
                                color: Colors.black,
                              )),
                          SizedBox(
                            height: 50.h,
                          ),
                          userProfileDataWidget(
                              textData: userProfileController.userProfileModel.phoneNumber,
                              iconData: Icon(
                                CupertinoIcons.phone,
                                color: Colors.black,
                              )),
                          SizedBox(
                            height: 300.h,
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
