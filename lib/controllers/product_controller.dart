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
    for (var pro in products) {
      if (pro.caffeteriaid == product.caffeteriaid &&
          pro.ProductName == product.ProductName) {
        Get.snackbar("The item is already added ",
            "${product.ProductName} is already exist  ");
        return;
      }
    }
    final addprd = firebaseFirestore.collection(collection).doc();
    final json = {
      "cafeteriaid": product.caffeteriaid,
      // "categoryid": product.categoryId,
      "id": addprd.id,
      "image": product.ProductPhoto,
      "name": product.ProductName,
      "price": product.ProductPrice,
    };
    await addprd.set(json);
  }

  // Stream<List<ProductModel>> getforcaff() => firebaseFirestore
  //     .collection(collection)
  //     .where("cafeteriaId", isEqualTo: "A")
  //     .snapshots()
  //     .map((event) =>
  //         event.docs.map((e) => ProductModel.fromMap(e.data())).toList());
}
