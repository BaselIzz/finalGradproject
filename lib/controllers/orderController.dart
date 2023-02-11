import 'package:get/get.dart';
import 'package:gradutionfinalv/model/order.dart';
import 'package:gradutionfinalv/model/product.dart';

import '../constants/firebase.dart';

class OrderController extends GetxController {
  static OrderController instace = Get.find();
  RxList<orderModel> orders = RxList<orderModel>([]);
  String collection = "orders";

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    orders.bindStream(getOrdertByTime());
  }

  Stream<List<orderModel>> getAllorders() =>
      firebaseFirestore.collection(collection).snapshots().map((event) =>
          event.docs.map((item) => orderModel.fromMap(item.data())).toList());

  void updateState(String orderid) {
    firebaseFirestore
        .collection(collection)
        .doc(orderid)
        .update({'status': 'Done'});
  }

  int productinoreder(ProductModel productModel) {
    int lenght = orders
        .where((p0) =>
            p0.cafeteriaid == productModel.caffeteriaid &&
            productModel.ProductID == p0.order.first.productId &&
            p0.status == "notDone")
        .toList()
        .length;
    return lenght;
  }

  void reorder(orderModel order) {
    var orderid = firebaseFirestore.collection(collection).doc();
    orderid.set({
      "served": false,
      "cafeteriaid": order.cafeteriaid,
      "order": order.order.map((e) => e.Tojason()).toList(),
      "orderid": orderid.id,
      "createdby": order.createdby,
      "time": DateTime.now().toString(),
      "status": "notDone",
      "useremail": order.useremail,
      "totalprice": order.totalprice,
      "userid": order.userid,
    });
  }

  void updateSarved(
    String orderid,
  ) {
    firebaseFirestore
        .collection(collection)
        .doc(orderid)
        .update({'sarved': true});
  }

  Stream<List<orderModel>> getOrdertByTime() => firebaseFirestore
      .collection(collection)
      .orderBy('time', descending: false)
      .snapshots()
      .map((event) =>
          event.docs.map((item) => orderModel.fromMap(item.data())).toList());

  Stream<List<orderModel>> getOrdertByQuantity() => firebaseFirestore
      .collection(collection)
      .orderBy('order', descending: false)
      .orderBy('quantity', descending: false)
      .snapshots()
      .map((event) =>
          event.docs.map((item) => orderModel.fromMap(item.data())).toList());
}
