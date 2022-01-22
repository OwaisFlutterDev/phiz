import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phiz/controller/card_controller.dart';
import 'package:phiz/model/product_model.dart';
import 'package:phiz/widgets/common_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleProductWidget extends StatelessWidget {

  final CartController cartController = Get.put(CartController());
  final ProductModel product;

   SingleProductWidget({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Column(
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 25.w),
                    child: Container(
                      height: 550.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          image: DecorationImage(image: NetworkImage(product.imageUrl),fit: BoxFit.cover)
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 60.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText(
                            title: product.name,
                            fontWidget: FontWeight.w600,
                            fontSize: 60.sp
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                commonText(
                                    title: "\$",
                                    fontSize: 58.sp
                                ),
                                commonText(
                                    title: product.price,
                                    fontSize: 58.sp
                                ),
                              ],
                            ),
                            InkWell(
                                onTap: (){
                                cartController.addProductToCart(product);
                                print(product);
                                },
                                child: Icon(Icons.shopping_cart_outlined,))
                          ],
                        ),

                      ],
                    ),
                  ),
                ],),

              SizedBox(height: 30.h,),
              Divider(),
              SizedBox(height: 30.h,)
            ],
          );
  }
}