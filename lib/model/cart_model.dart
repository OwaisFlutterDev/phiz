class CartModel{
  String id;
  String productId;
  String imageUrl;
  String name;
  String price;
  int quantity;

  CartModel(
      this.id,
      this.productId,
      this.name,
      this.imageUrl,
      this.price,
      this.quantity
      );

  CartModel.fromMap(Map<String, dynamic> data){
    id = data["id"];
    productId = data["productId"];
    name = data["name"];
    imageUrl = data["imageUrl"];
    price = data["price"];
    quantity = data["quantity"];
  }

  Map toJson() => {
  "id": id,
  "productId": productId,
  "name": name,
  "imageUrl": imageUrl,
  "price": price,
  "quantity": quantity
  };


}