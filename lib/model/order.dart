import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradutionfinalv/model/order_item.dart';

class orderModel {
  static const CAFFETERIAID = "cafeteriaid";
  static const OREDER = "order";
  static const ORDERID = "orderid";
  static const TIME = "time";
  static const STATUS = "status";
  static const USEREMAI = "useremail";
  static const TOTALPRICE = "totalprice";
  static const UIDUser = "userid";
  static const NameCreated = "createdby";

  String cafeteriaid;
  List<OrderItemModel> order;
  String orderid;
  String time;
  String userid;
  String useremail;
  String totalprice;
  String status;
  String createdby;

  orderModel(
      {this.cafeteriaid,
      this.orderid,
      this.status,
      this.time,
      this.totalprice,
      this.useremail,
      this.userid,
      this.createdby,
      this.order});
  orderModel.fromMap(Map<String, dynamic> data) {
    cafeteriaid = data[CAFFETERIAID];
    time = data[TIME];
    orderid = data[ORDERID];
    userid = data[UIDUser];
    useremail = data[USEREMAI];
    totalprice = data[TOTALPRICE];
    status = data[STATUS];
    createdby = data[NameCreated];
    order = _convertCartItems(List.from(data[OREDER] ?? []));
  }
  List<OrderItemModel> _convertCartItems(List cartFomDb) {
    List<OrderItemModel> _result = [];
    if (cartFomDb.length > 0) {
      cartFomDb.forEach((element) {
        _result.add(OrderItemModel.fromMap(element));
      });
    }
    return _result;
  }
}
