import 'package:cloud_firestore/cloud_firestore.dart';
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

  void reorder(orderModel order) async {
    QuerySnapshot orders = await FirebaseFirestore.instance
        .collection("orders")
        .where("cafeteriaid", isEqualTo: order.cafeteriaid)
        .orderBy("reciveId", descending: true)
        .limit(1)
        .get();
    int maxReciveId = 0;
    if (orders.docs.isNotEmpty) {
      Map<String, dynamic> data =
          orders.docs.first.data() as Map<String, dynamic>;
      maxReciveId = data["reciveId"] as int;
    }

    // Create a new Firestore document for the reordered order with the new reciveId
    CollectionReference ordersRef =
        FirebaseFirestore.instance.collection("orders");
    DocumentReference orderDocRef = ordersRef.doc();
    await orderDocRef.set({
      "served": false,
      "cafeteriaid": order.cafeteriaid,
      "order": order.order.map((e) => e.Tojason()).toList(),
      "orderid": orderDocRef.id,
      "createdby": order.createdby,
      "time": DateTime.now().toString(),
      "status": "notDone",
      "useremail": order.useremail,
      "totalprice": order.totalprice,
      "userid": order.userid,
      "reciveId":
          maxReciveId + 1, // Set the new reciveId for the reordered order
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
