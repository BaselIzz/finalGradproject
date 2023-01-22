class ProductModel {
  static const ID = "id";

  static const NAME = "product_name";

  static const PRICE = "product_price";

  static const PHOTO = "product_photo";

  static const EXIST = "is_Exist";

  static const Time = "product_time";
  static const CAFFETERIAID = "cafetria_id";
  static const DESCIPTION = "product_description";
  String ProductID;

  String ProductName;

  String ProductPrice;

  String ProductTime;
  String description;

  bool is_Exist;

  String ProductPhoto;
  String caffeteriaid;

  ProductModel(
      {this.ProductID,
      this.ProductName,
      this.ProductPhoto,
      this.ProductPrice,
      this.ProductTime,
      this.is_Exist,
      this.caffeteriaid,
      this.description});

  ProductModel.fromMap(Map<String, dynamic> data) {
    ProductID = data[ID];
    ProductName = data[NAME];
    description = data[DESCIPTION];
    ProductPrice = data[PRICE];
    ProductPhoto = data[PHOTO];
    caffeteriaid = data[CAFFETERIAID];
    is_Exist = data[EXIST] ?? false;
    ProductTime = data[Time];
  }

  Map toJson() => {
        ID: ProductID,
        NAME: ProductName,
        DESCIPTION: description,
        PRICE: ProductPrice,
        PHOTO: ProductPhoto,
        CAFFETERIAID: caffeteriaid,
        EXIST: is_Exist ?? true,
        Time: ProductTime,
      };
}
