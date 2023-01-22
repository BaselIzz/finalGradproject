// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gradutionfinalv/model/cafeteria.dart';
// import 'package:gradutionfinalv/widget/single_caffeteriaitem.dart';
// import 'package:gradutionfinalv/widget/single_product.dart';

// import '../constants/controllers.dart';
// import '../model/product.dart';

// // ignore: must_be_immutable
// class CafeteriaScreenForRecomandedMealWidget extends StatelessWidget {
//   String productname;
//   CafeteriaScreenForRecomandedMealWidget(this.productname, {Key key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => GridView.count(
//           crossAxisCount: 2,
//           childAspectRatio: .63,
//           padding: const EdgeInsets.all(10),
//           mainAxisSpacing: 4.0,
//           crossAxisSpacing: 10,
//           children: productsController.hashMap[productname].map((e) => null); 
//             ));
//   }
// }
