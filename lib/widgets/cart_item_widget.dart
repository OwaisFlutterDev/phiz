import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phiz/controller/card_controller.dart';
import 'package:phiz/model/cart_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phiz/widgets/common_widget.dart';

class CartItemWidget extends StatelessWidget{
  final CartModel cartItem;

  CartItemWidget({Key key, this.cartItem}) : super(key: key);
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            children: [
              Container(
                height: 270.h,
                width: 270.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage(cartItem.imageUrl),fit: BoxFit.cover)
                ),
              ),
              SizedBox(width: 30.w,),
              commonText(title: cartItem.name,fontSize: 50.sp),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: (){
                          cartController.removeCartItem(cartItem);
                        },
                        child: Icon(CupertinoIcons.minus_circle_fill)),
                  ],
                ),
              )

            ],
          ),
        ),
        SizedBox(height: 20.h,),
        Divider(),
        SizedBox(height: 20.h,),
      ],
    );
  }
}