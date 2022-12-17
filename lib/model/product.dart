class ProductModel {
  static const ID = "id";

  static const NAME = "product_name";

  static const PRICE = "product_price";

  static const PHOTO = "product_photo";

  static const EXIST = "is_Exist";

  static const Time = "product_time";
  static const CAFFETERIAID = "cafetria_id";
  String ProductID;

  String ProductName;

  String ProductPrice;

  String ProductTime;

  bool is_Exist;

  String ProductPhoto;
  String caffeteriaid;

  ProductModel(this.ProductID, this.ProductName, this.ProductPhoto,
      this.ProductPrice, this.ProductTime, this.is_Exist, this.caffeteriaid);

  ProductModel.fromMap(Map<String, dynamic> data) {
    ProductID = data[ID];
    ProductName = data[NAME];

    ProductPrice = data[PRICE];
    ProductPhoto = data[PHOTO];
    caffeteriaid = data[CAFFETERIAID];
    is_Exist = data[EXIST] ?? false;
    ProductTime = data[Time];
  }
}
