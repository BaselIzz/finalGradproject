import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradutionfinalv/model/product.dart';

import 'cart_item.dart';

// import 'cart_item.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const CART = "cart";
  static const ROLE = "role";
  static const LIST = "history_list";

  String id;
  String name;
  String email;
  List<CartItemModel> cart;
  String role;
  List<ProductModel> historyList;

  UserModel(
      {this.id,
      this.name,
      this.email,
      /* this.cart,*/ this.role,
      this.historyList});

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = (snapshot.data() as Map<String, dynamic>)[NAME];
    email = (snapshot.data() as Map<String, dynamic>)[EMAIL];
    id = (snapshot.data() as Map<String, dynamic>)[ID];
    cart = _convertCartItems(List.from(snapshot[CART] ?? []));
    role = (snapshot.data() as Map<String, dynamic>)[ROLE];
    historyList = _convertHistoryList(List.from(snapshot[LIST] ?? []));
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

  List<ProductModel> _convertHistoryList(List list) {
    List<ProductModel> _result = [];
    if (list.length > 0) {
      list.forEach((element) {
        _result.add(ProductModel.fromMap(element));
      });
    }
    return _result;
  }
}
