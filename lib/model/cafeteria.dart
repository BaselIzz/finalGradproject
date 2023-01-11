import 'package:cloud_firestore/cloud_firestore.dart';

class CafeteriaModel {
  static const HASUSER = "hasuser";
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const IS_ACTIVE = "is_Active";

  String cafeteriaId;
  String cafeteriaName;
  bool is_Active;
  bool hasuser;
  String email;

  CafeteriaModel(
      {this.cafeteriaId,
      this.cafeteriaName,
      this.email,
      this.hasuser,
      this.is_Active});

  CafeteriaModel.fromSnapshot(Map<String, dynamic> data) {
    cafeteriaName = data[NAME];
    cafeteriaId = data[ID];
    email = data[EMAIL].toString();
    is_Active = data[IS_ACTIVE] ?? false;
    hasuser = data[HASUSER] ?? false;
  }
}
