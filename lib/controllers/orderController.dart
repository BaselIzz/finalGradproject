import 'package:get/get.dart';
import 'package:gradutionfinalv/model/order.dart';

import '../constants/firebase.dart';

class OrderController extends GetxController {
  static OrderController instace = Get.find();
  RxList<orderModel> orders = RxList<orderModel>([]);
  String collection = "orders";

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    orders.bindStream(getAllorders());
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
}
