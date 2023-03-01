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
  static const SARVED = "sarved";
  static const PAYMENT = "payment";
  static const RecivedID = "reciveId";
  String cafeteriaid;
  List<OrderItemModel> order;
  String orderid;
  String time;
  String userid;
  String useremail;
  String totalprice;
  String status;
  String createdby;
  bool sarved;
  bool payment;
  int recivedId;
  orderModel(
      {this.cafeteriaid,
      this.orderid,
      this.status,
      this.time,
      this.totalprice,
      this.useremail,
      this.userid,
      this.createdby,
      this.order,
      this.sarved,
      this.payment,
      this.recivedId});
  orderModel.fromMap(Map<String, dynamic> data) {
    cafeteriaid = data[CAFFETERIAID];
    time = data[TIME];
    orderid = data[ORDERID];
    userid = data[UIDUser];
    useremail = data[USEREMAI];
    totalprice = data[TOTALPRICE];
    status = data[STATUS];
    createdby = data[NameCreated];
    sarved = data[SARVED] ?? false;
    payment = data[PAYMENT] ?? false;
    recivedId = data[RecivedID];
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
