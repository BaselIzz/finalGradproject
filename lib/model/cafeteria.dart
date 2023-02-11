import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gradutionfinalv/model/product.dart';
import 'package:gradutionfinalv/utils/splayTree.dart';

class CafeteriaModel {
  static const HASUSER = "hasuser";
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const IS_ACTIVE = "is_Active";
  static const Photo = "image";

  String cafeteriaId;
  String cafeteriaName;
  bool is_Active;
  bool hasuser;
  String email;
  String Caf_img;
  SplayTree<ProductModel> splayTree = SplayTree();

  CafeteriaModel(
      {this.cafeteriaId,
      this.cafeteriaName,
      this.email,
      this.hasuser,
      this.is_Active,
      this.Caf_img});

  CafeteriaModel.fromSnapshot(Map<String, dynamic> data) {
    cafeteriaName = data[NAME];
    cafeteriaId = data[ID];
    email = data[EMAIL].toString();
    is_Active = data[IS_ACTIVE] ?? false;
    hasuser = data[HASUSER] ?? false;
    Caf_img = data[Photo].toString();
  }
}
