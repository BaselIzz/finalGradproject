import 'package:cloud_firestore/cloud_firestore.dart';

class VendorModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const CAFFETERIAID = "cafeteriaid";
  static const ROLE = "role";

  String id;
  String name;
  String email;
  String role;
  String caffeteriaid;

  VendorModel({this.id, this.name, this.email, this.role});

  VendorModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = (snapshot.data() as Map<String, dynamic>)[NAME];
    email = (snapshot.data() as Map<String, dynamic>)[EMAIL];
    id = (snapshot.data() as Map<String, dynamic>)[ID];
    role = (snapshot.data() as Map<String, dynamic>)[role];
    caffeteriaid = (snapshot.data() as Map<String, dynamic>)[CAFFETERIAID];
  }
}
