import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:phiz/controller/user_auth_controlller.dart';
import 'package:phiz/model/cart_model.dart';
import 'package:phiz/model/product_model.dart';
import 'package:phiz/model/user_profile_model.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {

  UserProfileModel userProfileModel = UserProfileModel();
  final UserAuthController _userAuthController = Get.put(UserAuthController());


  //---------------------------------------------------------------------------
  //     -----============     add item in cart     ============-----------
  //---------------------------------------------------------------------------

  void addProductToCart(ProductModel product) async {

    final currentUser = FirebaseAuth.instance.currentUser;

    DocumentSnapshot _doc = await FirebaseFirestore.instance.collection(
        'users').doc(currentUser.uid).get();
    // ------ ===== condition to check the data is get  or not =====  ------
    _doc != null ? print("Get Data from firebase") : print("Get null Data from firebase");


    userProfileModel = UserProfileModel.fromDocumentSnapshot(_doc);

    try {

      final UserAuthController _userAuthController = Get.put(UserAuthController());
      if (_isItemAlreadyAdded(product)) {
        Get.snackbar("Check your cart", "${product.name} is already added");
      } else {
        String itemId = Uuid().toString();
        print(itemId);
        _userAuthController.updateUserData({
          "cart": FieldValue.arrayUnion([
            {
              "id": itemId,
              "productId": product.id,
              "name": product.name,
              "imageUrl": product.imageUrl,
              "price": product.price,
              "quantity": 1,
            }
          ])
        });
        Get.snackbar("Item added", "${product.name} was added to your cart");
      }
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  //---------------------------------------------------------------------------
  //     -----============ To check item is add in cart ============-----------
  //---------------------------------------------------------------------------

  bool _isItemAlreadyAdded(ProductModel product) => _userAuthController.userModel.value.cart
          .where((item) => item.productId == product.id)
          .isNotEmpty;


  //---------------------------------------------------------------------------
  //     -----============ remove item from cart ============-----------
  //---------------------------------------------------------------------------


  void removeCartItem(CartModel cartItem) {
    final UserAuthController _userAuthController = Get.put(UserAuthController());

    try {
      _userAuthController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
    } catch (e) {
      Get.snackbar("Error", "Cannot remove this item");
      debugPrint(e.message);
    }
  }

}