import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradutionfinalv/constants/controllers.dart';
import 'package:gradutionfinalv/model/product.dart';
import 'package:gradutionfinalv/values/values.dart';
import 'package:gradutionfinalv/widget/SingleWidgetSearch.dart';
import 'package:gradutionfinalv/widget/custom_text_from_field.dart';

class SearchScreen extends StatelessWidget {
  final controller = Mycontroller();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: CustomTextFormField(
                  onchange: (_) =>
                      controller.filterList(controller.textedit.text),
                  controller: controller.textedit,
                  fillColor: AppColors.kFoodyBiteDarkBackground,
                  borderColor: Colors.green,
                  prefixIconColor: Colors.white,
                  autocorrect: true,
                  hasPrefixIcon: true,
                  icon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: controller.filteredItems.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: .63,
                          padding: EdgeInsets.all(10),
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 10,
                          children: productsController.products
                              .map((ProductModel product) {
                            return SingleProductSearch(product: product);
                          }).toList());
                    }
                    final filteredItems = snapshot.data as List<ProductModel>;
                    return GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .63,
                      padding: EdgeInsets.all(10),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 10,
                      children: filteredItems.map((ProductModel product) {
                        return SingleProductSearch(product: product);
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class Mycontroller extends GetxController {
  final textFieldValue = ''.obs;
  final filteredItems = [].obs;
  TextEditingController textedit = TextEditingController();
  filterList(String text) {
    filteredItems.value = productsController.products
        .where(
            (p0) => p0.ProductName.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }
}
