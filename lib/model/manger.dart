import 'package:cloud_firestore/cloud_firestore.dart';

import 'cafeteria.dart';

class MangerModel {
  static const ID = "id";
  static const USERNAME = "name";
  static const EMAIL = "email";
  static const CAFETERIA = "cafeteria";
  static const VENDORS = "vendor";
  static const PASSWORD = "password";

  String mangerId;

  String userName;

  //List<VendorModel> vendors;

  CafeteriaModel cafeteria;

  String password;

  MangerModel.fromSnapshot(DocumentSnapshot snapshot) {
    mangerId = (snapshot.data() as Map<String, dynamic>)[ID];
    userName = (snapshot.data() as Map<String, dynamic>)[USERNAME];
    // vendors = (snapshot.data() as Map<String, dynamic>)[VENDORS];
    cafeteria = (snapshot.data() as Map<String, dynamic>)[CAFETERIA];
    password = (snapshot.data() as Map<String, dynamic>)[PASSWORD];
  }
}
