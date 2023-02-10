class ProductModel extends Comparable<ProductModel> {
  static const ID = "id";

  static const NAME = "product_name";

  static const PRICE = "product_price";

  static const PHOTO = "product_photo";

  static const EXIST = "is_Exist";

  static const Time = "product_time";
  static const CAFFETERIAID = "cafetria_id";
  static const DESCIPTION = "product_description";
  static const TEMP = "tempStatus";
  String ProductID;

  String ProductName;

  String ProductPrice;

  String ProductTime;
  String description;

  bool is_Exist;

  String ProductPhoto;
  String caffeteriaid;
  String tempStatus;

  ProductModel(
      {this.ProductID,
      this.ProductName,
      this.ProductPhoto,
      this.ProductPrice,
      this.ProductTime,
      this.is_Exist,
      this.caffeteriaid,
      this.tempStatus,
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
    tempStatus = data[TEMP];
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
        TEMP: tempStatus,
      };

  @override
  int compareTo(ProductModel other) {
    if (this.ProductPrice.compareTo(other.ProductPrice) < 0) {
      return -1;
    } else if (this.ProductPrice.compareTo(other.ProductPrice) > 0) {
      return 1;
    } else {
      return 0;
    }
  }
}
