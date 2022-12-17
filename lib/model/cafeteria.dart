import 'package:cloud_firestore/cloud_firestore.dart';

class CafeteriaModel {
  static const HASUSER = "hasuser";
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const MENU = "menu";
  static const IS_ACTIVE = "is_Active";
  static const DESCREPTION = "descreption";
  static const VENDORS = "vendor";

  String cafeteriaId;
  String cafeteriaName;
  // MenuModel menu;
  bool is_Active;
  //String Descreption;
  bool hasuser;
  // List<VendorModel> vendors;
  String email;

  CafeteriaModel(this.cafeteriaId, this.cafeteriaName, this.email, this.hasuser,
      this.is_Active);

  CafeteriaModel.fromSnapshot(Map<String, dynamic> data) {
    cafeteriaName = data[NAME];
    cafeteriaId = data[ID];
    email = data[EMAIL].toString();
    //  menu = (snapshot.data() as Map<String, dynamic>)[MENU];
    is_Active = data[IS_ACTIVE] ?? false;
    hasuser = data[HASUSER] ?? false;
    //Descreption = (snapshot.data() as Map<String, dynamic>)[DESCREPTION];
    // vendors = (snapshot.data() as Map<String, dynamic>)[VENDORS];
  }
}
