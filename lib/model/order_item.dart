import 'dart:ffi';

class OrderItemModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const QUANTITY = "quantity";
  static const COST = "cost";
  static const PRODUCT_ID = "productId";

  String id;
  String image;
  String name;
  String quantity;
  String cost;
  String productId;
  OrderItemModel(
      {this.id,
      this.image,
      this.cost,
      this.name,
      this.productId,
      this.quantity});
  OrderItemModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    image = data[IMAGE];
    name = data[NAME];
    quantity = data[QUANTITY].toString();
    cost = data[COST];
    productId = data[PRODUCT_ID];
  }
  Map Tojason() => {
        ID: id,
        PRODUCT_ID: productId,
        IMAGE: image,
        NAME: name,
        QUANTITY: quantity,
        COST: ((cost * int.parse(quantity))).toString(),
      };
}
