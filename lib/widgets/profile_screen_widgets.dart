import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phiz/constants/constant.dart';
import 'package:phiz/controller/user_profile_controller.dart';
import 'common_widget.dart';


// --------------------------------------------------------------------------
//      ===============  Alert Dialog For User Data Update ============
// --------------------------------------------------------------------------

Widget buildAlertDialogForUpdate(UserProfileController controller) {
  return AlertDialog(
    scrollable: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    backgroundColor: blueColor,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ------- profile image -------
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                controller.imageFile != null
                    ? CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue.shade800,
                  backgroundImage: new FileImage(controller.imageFile,),
                )
                    : CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue.shade800,
                  backgroundImage: NetworkImage(
                      controller.userProfileModel.image),
                ),

                Positioned(
                    right: 1,
                    bottom: 0,
                    child: InkWell(
                      onTap: () {
                        controller.getImage();
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(
                          CupertinoIcons.camera,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ))
              ],
            ),
          ],
        ),

        // ---------  user personal data ---------

        SizedBox(
          height: 40.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                style: GoogleFonts.poppins(
                    textStyle:
                    TextStyle(fontSize: 42.sp, color: Colors.white)),
                controller:
                controller.usernameProfileController,
              ),
              SizedBox(
                height: 30.h,
              ),
              TextField(
                decoration: InputDecoration(
                    enabled: false,
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.white70)),
                style: GoogleFonts.poppins(
                    textStyle:
                    TextStyle(fontSize: 42.sp, color: Colors.white)),
                controller: controller.emailProfileController,
              ),
              SizedBox(
                height: 30.h,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Phone No",
                    hintStyle: TextStyle(color: Colors.white70)),
                style: GoogleFonts.poppins(
                    textStyle:
                    TextStyle(fontSize: 42.sp, color: Colors.white)),
                controller:
                controller.phoneNumberProfileController,
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 60.h,
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 30.w),
          child: Container(
            height: 100.h,
            width: Get.size.width,
            decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(20.r)),
            child: InkWell(
              onTap: () {
                controller.updateDataOfProfile();
              },
              child: Center(
                  child: Text("Update Profile",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 42.sp, color: Colors.white)))),
            ),
          ),
        )
      ],
    ),
  );
}

// -----------------------------------------------------------------------
//      ===============  User Profile Data Widget ===========
// -----------------------------------------------------------------------

Widget userProfileDataWidget({String textData, Icon iconData, Function onTap}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Container(
          height: 140.h,
          width: 140.r,
          decoration: BoxDecoration(
              color: Colors.blue.shade700.withOpacity(0.09),
              borderRadius: BorderRadius.circular(100.r)
          ),
          child: iconData,
        ),
        SizedBox(width: 35.w,),
        commonText(title: textData,color: Colors.black),
      ],
      //
    ),
  );
}