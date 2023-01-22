import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:string_similarity/string_similarity.dart';

import '../constants/firebase.dart';
import '../model/product.dart';

class ProductsController extends GetxController {
  static ProductsController instace = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxMap<ProductModel, List<ProductModel>> Reclist =
      RxMap<ProductModel, List<ProductModel>>();
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

  WorkerCallback<List<ProductModel>> getrecomander() {
    Reclist.clear();
    List<List<double>> descriptionMatrix = [];
    for (var i = 0; i < products.length; i++) {
      descriptionMatrix.add([]);
      for (var j = 0; j < products.length; j++) {
        var similarity = StringSimilarity.compareTwoStrings(
            products[i].description, products[j].description);
        descriptionMatrix[i].add(similarity);
      }
    }
    List<ProductModel> data = [];
    // Print the similarity scores for the first meal
    for (var i = 0; i < products.length; i++) {
      for (var j = 0; j < products.length; j++) {
        if (descriptionMatrix[i][j] >= 0.5) {
          print(
              "${products[i].ProductName} and ${products[j].ProductName}   ${descriptionMatrix[i][j]}");
          data.add(products[j]);
        }
      }
      Reclist.putIfAbsent(products[i], () => data);
    }
    return null;
  }

  // Stream<List<ProductModel>> getforcaff() => firebaseFirestore
  //     .collection(collection)
  //     .where("cafeteriaId", isEqualTo: "A")
  //     .snapshots()
  //     .map((event) =>
  //         event.docs.map((e) => ProductModel.fromMap(e.data())).toList());

}
