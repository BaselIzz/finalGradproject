import 'package:flutter/material.dart';
import 'package:gradutionfinalv/model/cafeteria.dart';
import 'package:gradutionfinalv/widget/custom_text.dart';

class SingleCaffeteriaitem extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final CafeteriaModel Caffeteia;
  // ignore: non_constant_identifier_names
  const SingleCaffeteriaitem({Key key, this.Caffeteia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.5),
                  offset: const Offset(3, 2),
                  blurRadius: 7)
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    Caffeteia.Caf_img,
                    width: 200,
                    height: 100,
                    fit: BoxFit.contain,
                  )),
            ),
            CustomText(
              text: Caffeteia.cafeteriaName,
              size: 18,
              weight: FontWeight.bold,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SizedBox(
                  width: 10,
                ),
                //if you want to add any button  on left and if you want you can add to button by remove above
              ],
            ),
          ],
        ));
  }
}
