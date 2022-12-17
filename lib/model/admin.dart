import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const CART = "cart";
  static const ROLE = "role";

  String id;
  String name;
  String email;
  String role;

  AdminModel({this.id, this.name, this.email, this.role});

  AdminModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = (snapshot.data() as Map<String, dynamic>)[NAME];
    email = (snapshot.data() as Map<String, dynamic>)[EMAIL];
    id = (snapshot.data() as Map<String, dynamic>)[ID];
    role = (snapshot.data() as Map<String, dynamic>)[role];
  }
}
