import 'package:cloud_firestore/cloud_firestore.dart';

class orderModel {
  static const CAFFETERIAID = "cafeteriaid";
  static const OREDER = "order";
  static const ORDERID = "orderid";
  static const TIME = "time";
  static const STATUS = "status";
  static const USEREMAI = "useremail";
  static const TOTALPRICE = "totalprice";
  static const UIDUser = "userid";

  String cafeteriaid;
  //List<> order ;
  String orderid;
  String time;
  String userid;
  String useremail;
  String totalprice;
  String status;

  orderModel(
      {this.cafeteriaid,
      this.orderid,
      this.status,
      this.time,
      this.totalprice,
      this.useremail,
      this.userid});
  orderModel.fromMap(Map<String, dynamic> data) {
    cafeteriaid = data[CAFFETERIAID];
    time = data[TIME];
    orderid = data[ORDERID];
    userid = data[UIDUser];
    useremail = data[USEREMAI];
    totalprice = data[TOTALPRICE];
    status = data[STATUS];
  }
}
