import 'package:gradutionfinalv/model/product.dart';

class Node<T> {
  T val;
  int count;
  Node<T> left;
  Node<T> right;

  Node(this.val) {
    this.count = 1;
    this.left = null;
    this.right = null;
  }
}
