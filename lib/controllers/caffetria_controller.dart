import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  void addCaffeteria(CafeteriaModel caffeteia) async {
    final addcaf = firebaseFirestore.collection(collection).doc();
    await addcaf.set({
      "hasuser": false,
      "name": caffeteia.cafeteriaName,
      "email": caffeteia.email,
      "is_Active": false,
      "id": addcaf.id,
      // "Photo":
    });
  }
}
