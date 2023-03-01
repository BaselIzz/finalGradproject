import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/cafeteria.dart';
import 'package:gradutionfinalv/widget/CafeteriaScreenForRecomandedMealWidget.dart';
import 'package:gradutionfinalv/widget/ProductWidget.dart';
import 'package:gradutionfinalv/widget/foody_bite_card.dart';

class CafeteriaScreenForRecomandedMeal extends StatelessWidget {
  String name;
  CafeteriaScreenForRecomandedMeal(this.name, {Key key}) : super(key: key);
  List<CafeteriaModel> caf = [];
  @override
  Widget build(BuildContext context) {
    findcafeteriaforProduct();
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text(
              "Cafeteriaes For $name",
              style: const TextStyle(fontSize: 13),
            )),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
              scrollDirection: Axis.vertical,
              children: caf.map((CafeteriaModel caffeteria) {
                return FoodyBiteCard(
                  caffeteria: caffeteria,
                  imagePath: caffeteria.Caf_img,
                  imageHeight: 100,
                  cardHeight: 170,
                );
              }).toList()),
        ));
  }

  void findcafeteriaforProduct() {
    for (String caff in productsController.hashMap[name].toList()) {
      CafeteriaModel cafeteria = caffetriaController.getCaffeteria(caff);
      if (cafeteria != null) {
        caf.add(cafeteria);
      }
    }
  }
}
