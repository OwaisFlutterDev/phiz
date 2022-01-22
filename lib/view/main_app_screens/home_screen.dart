import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phiz/constants/constant.dart';
import 'package:phiz/controller/product_controller.dart';
import 'package:phiz/model/product_model.dart';
import 'package:phiz/view/main_app_screens/cart_screen.dart';
import 'package:phiz/widgets/common_widget.dart';
import 'package:phiz/widgets/single_product_widget.dart';

class HomeScreen extends StatelessWidget{
  final  ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ----- body ------
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 50.w),
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h,),

                  // -- -- ==== title and cart ==== -- --
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonText(title: "Welcome To Phiz...!",color: blueColor,fontSize: 65.sp, fontWidget: FontWeight.bold),
                      InkWell(
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () => Get.to(() => CartScreen()),
                                child: Icon(CupertinoIcons.shopping_cart,color: Colors.red,size: 85.r,)),
                            SizedBox(width: 10.w,),

                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 50.h,),
                  // -----------====== Product list ========= ----------
                  Obx(
                        () => SingleChildScrollView(
                          child: GridView.count(
                              crossAxisCount: 1,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                              childAspectRatio: .99,
                              padding: const EdgeInsets.all(10),
                              // mainAxisSpacing: 4.0,
                              // crossAxisSpacing: 10,
                              children: _productController.productDataList.map((ProductModel product) {
                                return SingleProductWidget(product: product,);
                              }).toList()),
                        ))
                ],)
          ),
        ),
      ),
    );
  }
}