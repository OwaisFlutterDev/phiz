import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  ProductModel({
    this.id,
    this.imageUrl,
    this.name,
    this.price,
  });
  String id;
  String imageUrl;
  String name;
  String price;

  ProductModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc["id"];
    imageUrl = doc["imageUrl"];
    name = doc["name"];
    price = doc["price"];
  }

}