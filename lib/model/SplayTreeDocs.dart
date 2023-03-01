import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradutionfinalv/model/product.dart';

class SplayTreeDocs {
  List<ProductModel> SplayTreeDocsdlist;
  SplayTreeDocs({this.SplayTreeDocsdlist});
  SplayTreeDocs.fromSnapShot(Map<String, dynamic> data) {
    SplayTreeDocsdlist = convertTolist(List.from(data["List"]));
  }

  List<ProductModel> convertTolist(List list) {
    List<ProductModel> _result = [];
    if (list.length > 0) {
      list.forEach((element) {
        _result.add(ProductModel.fromMap(element));
      });
    }
    return _result;
  }
}
