class CartItemModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const QUANTITY = "quantity";
  static const COST = "cost";
  static const PRICE = "price";
  static const PRODUCT_ID = "productId";
  static const Caffeteria_ID = "cafetriaId";

  String id;
  String image;
  String name;
  int quantity;
  double cost;
  String productId;
  double price;
  String cafeteriaId;

  CartItemModel(
      {this.productId,
      this.id,
      this.image,
      this.name,
      this.quantity,
      this.cost,
      this.cafeteriaId});

  CartItemModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    image = data[IMAGE];
    name = data[NAME];
    quantity = data[QUANTITY];
    cost = (double.parse(data[COST])).toDouble();
    productId = data[PRODUCT_ID];
    price = (double.parse(data[PRICE])).toDouble();
    cafeteriaId = data[Caffeteria_ID];
  }

  Map toJson() => {
        ID: id,
        PRODUCT_ID: productId,
        IMAGE: image,
        NAME: name,
        QUANTITY: quantity,
        COST: ((price * quantity)).toString(),
        PRICE: (price).toString(),
        Caffeteria_ID: cafeteriaId,
      };
  Map toJsonOreder() => {
        ID: id,
        PRODUCT_ID: productId,
        IMAGE: image,
        NAME: name,
        QUANTITY: quantity,
        COST: ((price * quantity)).toString(),
      };
  getcafeteriaid() => cafeteriaId;
}
