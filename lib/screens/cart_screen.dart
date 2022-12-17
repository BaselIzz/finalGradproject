import 'package:flutter/material.dart';
import 'package:gradutionfinalv/widget/shopping_cart.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShoppingCartWidget(),
    );
  }
}
