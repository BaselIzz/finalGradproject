import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../constants/controllers.dart';
import '../model/cafeteria.dart';
import '../widget/foody_bite_card.dart';

class CaffeteriaItemScreen extends StatelessWidget {
  const CaffeteriaItemScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(10),
          child: ListView(
              scrollDirection: Axis.vertical,
              children: caffetriaController.cafeterias
                  .map((CafeteriaModel caffeteria) {
                return FoodyBiteCard(
                  caffeteria: caffeteria,
                  //cardTitle: "pizza",
                  imagePath:
                      "https://heavy.com/wp-content/uploads/2020/12/GettyImages-133281966-e1608688624818.jpg?quality=65&strip=all",
                  imageHeight: 100,
                  cardHeight: 170,
                );
              }).toList()),
        ));
  }
}
