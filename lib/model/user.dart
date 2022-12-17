import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item.dart';

// import 'cart_item.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const CART = "cart";
  static const ROLE = "role";

  String id;
  String name;
  String email;
  List<CartItemModel> cart;
  String role;

  UserModel({this.id, this.name, this.email, /* this.cart,*/ this.role});

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = (snapshot.data() as Map<String, dynamic>)[NAME];
    email = (snapshot.data() as Map<String, dynamic>)[EMAIL];
    id = (snapshot.data() as Map<String, dynamic>)[ID];
    cart = _convertCartItems(List.from(snapshot[CART] ?? []));
    role = (snapshot.data() as Map<String, dynamic>)[ROLE];
  }

  List<CartItemModel> _convertCartItems(List cartFomDb) {
    List<CartItemModel> _result = [];
    if (cartFomDb.length > 0) {
      cartFomDb.forEach((element) {
        _result.add(CartItemModel.fromMap(element));
      });
    }
    return _result;
  }
}
