import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/cafeteria.dart';

import '../constants/firebase.dart';
import '../model/secdule.dart';

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
      "image": caffeteia.Caf_img
    });
  }

  void changehasuser(String cafeteriaid) {
    firebaseFirestore.collection(collection).doc(cafeteriaid).update({
      "hasuser": true,
      "email": userController.email.text,
    });
  }

  // void getCaferteriaHasThisMeal() async {
  //   CollectionReference usersref = firebaseFirestore.collection("product");
  //   await usersref
  //       .where("product_name", isEqualTo: "ms7ab");
  // }

  String getCaffeterianame(String cafeteriaid) {
    CafeteriaModel caf =
        cafeterias.where((p0) => p0.cafeteriaId == cafeteriaid).first;
    return caf.cafeteriaName;
  }

  CafeteriaModel getCaffeteria(cafeteriaid) {
    CafeteriaModel caf =
        cafeterias.where((p0) => p0.cafeteriaId == cafeteriaid).first;
    return caf;
  }

  void addSecdule(Secdule secdule) async {
    final addRecord = firebaseFirestore.collection("secdule").doc();
    await addRecord.set({
      'cafateriaId': secdule.cafateriaId,
      'end_work_hour': secdule.end_work_hour,
      'start_work_hour': secdule.start_work_hour,
      'vendorid': secdule.vendorid,
      'work_date': secdule.work_date,
      'works_hours': secdule.works_hours
    });
  }
}
