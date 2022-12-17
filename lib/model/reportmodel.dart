import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

// import 'VendorModel.dart';
// import 'MealModel.dart';

class ReportModel {
  static const ID = "id";

  static const PRICE = "price";

  static const MEALS = "meals";

  static const DESCREPTION = "descreption";

  static const CREATEDAT = "createdAt";

  static const MONTHLYSHELL = "monthlySell";

  static const VENDORDAY = "vendorDay";

  static const VENDOR = "vendor";

  Long reportID;

  // List<MealModel> meals;

  // List<VendorModel> vendors;

  DateTime createdAt;

  Double monthlySell;

  int vendorDay; // this to know  how much days vendor work  ;

  ReportModel();

  ReportModel.fromSnapshot(DocumentSnapshot snapshot) {
    reportID = (snapshot.data() as Map<String, dynamic>)[ID];
    // meals = (snapshot.data() as Map<String, dynamic>)[MEALS];
    // vendors = (snapshot.data() as Map<String, dynamic>)[VENDOR];
    createdAt = (snapshot.data() as Map<String, dynamic>)[CREATEDAT];
    monthlySell = (snapshot.data() as Map<String, dynamic>)[MONTHLYSHELL];
    vendorDay = (snapshot.data() as Map<String, dynamic>)[VENDORDAY];
  }
}
