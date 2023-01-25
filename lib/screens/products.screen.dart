import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/widget/ProductWidget.dart';

class ProductScreens extends StatelessWidget {
  String cafeteriaId;
  ProductScreens(this.cafeteriaId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title:
                Text("${caffetriaController.getCaffeterianame(cafeteriaId)}")),
        body: ProductsWidget(cafeteriaId));
  }
}
