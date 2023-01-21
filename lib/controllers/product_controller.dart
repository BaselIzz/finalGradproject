import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/cafeteria.dart';

import '../constants/firebase.dart';
import '../model/product.dart';

class ProductsController extends GetxController {
  static ProductsController instace = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  List<String> show = <String>[];
  HashMap<String, List<String>> hashMap = HashMap<String, List<String>>();

  String collection = "product";
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    products.bindStream(getAllProducts());
    print(products.length);
    print("inside product controller");
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

  void getCaferteriaIdsfromPrdouct() async {
// هاي عشات لما يكبس على الميل في الريكمونديشن يفتح ع واجهة كافتيريات

    List<ProductModel> list =
        products.where((p0) => p0.ProductName == "ms7ab").toList();
    print(list.length);
    list.forEach((element) {
      show.add(element.caffeteriaid);
    });

    //  products.where((p0) => p0.ProductName == products[i].ProductName).forEach((element) {
    //  hashMap.putIfAbsent(products[i].ProductName, () => products[i].caffeteriaid)
    // })
    //
  }

  void getmeso() async {
    List<String> list_of_id = <String>[];

    for (int i = 0; i < productsController.products.length; i++) {
      list_of_id.clear();
      list_of_id.add(productsController.products[i].caffeteriaid);
      for (int j = 0; j < productsController.products.length; j++) {
        if (productsController.products[i].ProductName ==
                productsController.products[j].ProductName &&
            i != j) {
          list_of_id.add(productsController.products[j].caffeteriaid);
        }
      }
      hashMap.putIfAbsent(
          productsController.products[i].ProductName, () => list_of_id);
      print(list_of_id.length);
      print(hashMap[productsController.products[i].ProductName]);
    }
  }

  void getcafeteriaAfterPressingInRecomandedmeal() async {
    CollectionReference cafeteriaCollection =
        FirebaseFirestore.instance.collection('cafeteria');

    await cafeteriaCollection
        .where("id", whereIn: ["tBv0ganKL4dNta2Wd615", "E165llb3JxaY7Ez5a94c"])
        .get()
        .then((value) {
          value.docs.forEach((element) {
            print(element.data());
            print("%%%%%%%%%%%%%%%");
          });
        });
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
