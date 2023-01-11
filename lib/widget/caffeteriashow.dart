import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/cafeteria.dart';
import 'package:gradutionfinalv/widget/foody_bite_card.dart';
import 'package:gradutionfinalv/widget/single_caffeteriaitem.dart';

class CaffeteiaShow extends StatelessWidget {
  const CaffeteiaShow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.count(
          crossAxisCount: 2,
          childAspectRatio: .63,
          padding: const EdgeInsets.all(20),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 40,
          children:
              caffetriaController.cafeterias.map((CafeteriaModel caffeteria) {
            return Container(
              child: SingleCaffeteriaitem(
                Caffeteia: caffeteria,
              ),
            );
          }).toList()),
    );
  }
}
