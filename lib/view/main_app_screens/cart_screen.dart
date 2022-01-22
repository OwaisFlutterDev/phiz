import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phiz/constants/constant.dart';
import 'package:phiz/controller/user_auth_controlller.dart';
import 'package:phiz/widgets/cart_item_widget.dart';
import 'package:phiz/widgets/common_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget{

  final UserAuthController userAuthController = Get.put(UserAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              children: [
                SizedBox(height: 30.h, ),
                //---- title ----
                Row(
                  children: [
                    InkWell(
                        onTap: () => Get.back(),
                        child: Icon(CupertinoIcons.back, color: blueColor,size: 65.r,)),
                    SizedBox(width: 30.w,),
                    commonText(title: "Cart Screen",color: blueColor,fontSize: 70.sp, fontWidget: FontWeight.bold),

                  ],
                ),
                SizedBox(height: 30.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 90.w),
                  child: Row(
                    children: [
                      commonText(title: "The Item You Selected."),
                    ],
                  ),
                ),
                SizedBox(height: 50.h,),

               // ------- ======== cart item ======== -------
                Obx(() => Column(children: userAuthController.userModel.value.cart
                        .map((cartItem) => CartItemWidget(cartItem: cartItem))
                    .toList(),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
