import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/widget/CafeteriaScreenForRecomandedMealWidget.dart';
import 'package:gradutionfinalv/widget/ProductWidget.dart';

class CafeteriaScreenForRecomandedMeal extends StatelessWidget {
  String name;
  CafeteriaScreenForRecomandedMeal(this.name, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text("Cafeteriaes")),
        body: Text("malik ${productsController.hashMap[name].toList()}"));
  }
}
