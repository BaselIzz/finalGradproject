import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../constants/firebase.dart';
import '../model/product.dart';

class ProductsController extends GetxController {
  static ProductsController instace = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  String collection = "product";
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<ProductModel>> getAllProducts() =>
      firebaseFirestore.collection(collection).snapshots().map((event) =>
          event.docs.map((item) => ProductModel.fromMap(item.data())).toList());

  void addproduct(ProductModel product) async {
    if (isadded(product)) {
      Get.snackbar("The item is already added ",
          "${product.ProductName} is already exist  ");
      return;
    }

    final addprd = firebaseFirestore.collection(collection).doc();
    final json = {
      "cafetria_id": product.caffeteriaid,
      // "categoryid": product.categoryId,
      "id": addprd.id,
      "product_photo": product.ProductPhoto,
      "product_name": product.ProductName,
      "product_price": product.ProductPrice,
      "is_Exist": product.is_Exist,
      "product_time": product.ProductTime,
      "product_description": product.description
    };
    await addprd.set(json);
  }

  void updateStatus(String id, bool status) {
    firebaseFirestore
        .collection(collection)
        .doc(id)
        .update({"is_Exist": !status});
  }

  bool isadded(ProductModel product) {
    return products.where((p0) => p0 == product).isNotEmpty;
  }

  // Stream<List<ProductModel>> getforcaff() => firebaseFirestore
  //     .collection(collection)
  //     .where("cafeteriaId", isEqualTo: "A")
  //     .snapshots()
  //     .map((event) =>
  //         event.docs.map((e) => ProductModel.fromMap(e.data())).toList());

}
