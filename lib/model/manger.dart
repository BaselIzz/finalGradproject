import 'package:cloud_firestore/cloud_firestore.dart';

import 'cafeteria.dart';

class MangerModel {
  static const ID = "id";
  static const USERNAME = "name";
  static const EMAIL = "email";
  static const CAFETERIA = "cafeteriaid";
  static const ROLE = "role";

  String mangerId;

  String userName;
  String userEmail;

  String cafeteriaid;

  String role;

  MangerModel({this.mangerId, this.userName, this.userEmail, this.role});

  MangerModel.fromSnapshot(DocumentSnapshot snapshot) {
    mangerId = (snapshot.data() as Map<String, dynamic>)[ID];
    userName = (snapshot.data() as Map<String, dynamic>)[USERNAME];
    cafeteriaid = (snapshot.data() as Map<String, dynamic>)[CAFETERIA];
    role = (snapshot.data() as Map<String, dynamic>)[ROLE];
    userEmail = (snapshot.data() as Map<String, dynamic>)[EMAIL];
  }
}
