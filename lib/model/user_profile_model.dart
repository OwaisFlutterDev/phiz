import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phiz/model/cart_model.dart';

class UserProfileModel {
  UserProfileModel({
    this.uid,
    this.username,
    this.image,
    this.phoneNumber,
    this.email,
    this.cart
  });

  String uid;
  String username;
  String email;
  String image;
  String phoneNumber;
  List<CartModel> cart;

  UserProfileModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    uid = doc["uid"];
    username = doc["username"];
    email = doc["email"];
    image = doc["image"];
    phoneNumber = doc["phoneNumber"];
    cart = _convertCartItems(doc["cart"] ?? []);
  }

  List<CartModel> _convertCartItems(List cartFomDb){
    List<CartModel> _result = [];
    if(cartFomDb.length > 0){
      cartFomDb.forEach((element) {
        _result.add(CartModel.fromMap(element));
      });
    }
    return _result;
  }

  List cartItemsToJson() => cart.map((item) => item.toJson()).toList();
}