import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/model/cafeteria.dart';

import '../constants/firebase.dart';

class CaffetriaController extends GetxController {
  static CaffetriaController instace = Get.find();
  RxList<CafeteriaModel> cafeterias = RxList<CafeteriaModel>([]);
  String collection = "cafeteria";
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    cafeterias.bindStream(getAllcafeteria());
  }

  Stream<List<CafeteriaModel>> getAllcafeteria() => firebaseFirestore
      .collection(collection)
      .snapshots()
      .map((event) => event.docs
          .map((item) => CafeteriaModel.fromSnapshot(item.data()))
          .toList());
}
