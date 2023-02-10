import 'dart:collection';

import 'package:gradutionfinalv/utils/node.dart';

class SplayTree<T extends Comparable<T>> {
  Node<T> root;
  int size;

  SplayTree() {
    this.root = null;
    size = 0;
  }

  void insert(T val) {
    root = _insert(root, val);
    size++;
  }

  int length() {
    return size;
  }

  Node<T> _insert(Node<T> root, T val) {
    if (root == null) {
      return Node<T>(val);
    }
    if (val == root.val) {
      root.count++;
      return root;
    }
    if (val.compareTo(root.val) < 0) {
      root.left = _insert(root.left, val);
      root = splay(root, val);
    } else {
      root.right = _insert(root.right, val);
      root = splay(root, val);
    }
    return root;
  }

  Node<T> splay(Node<T> root, T val) {
    if (root == null || root.val == val) {
      return root;
    }
    if (val is Comparable<T>) {
      if (val.compareTo(root.val) < 0) {
        if (root.left == null) {
          return root;
        }
        if (val.compareTo(root.left.val) < 0) {
          root.left.left = splay(root.left.left, val);
          root = rightRotate(root);
        } else {
          root.left.right = splay(root.left.right, val);
          if (root.left.right != null) {
            root.left = leftRotate(root.left);
          }
        }
        return root.left == null ? root : rightRotate(root);
      } else {
        if (root.right == null) {
          return root;
        }
        if (val.compareTo(root.right.val) > 0) {
          root.right.right = splay(root.right.right, val);
          root = leftRotate(root);
        } else {
          root.right.left = splay(root.right.left, val);
          if (root.right.left != null) {
            root.right = rightRotate(root.right);
          }
        }
        return root.right == null ? root : leftRotate(root);
      }
    }
    throw new ArgumentError('value must be comparable');
  }

  List<T> topKFrequent(int k) {
    ListQueue<Node<T>> pq = ListQueue<Node<T>>();
    _inorder(root, pq);
    sortListQueue(pq);
    List<T> res = <T>[];
    while (k-- > 0 && pq.isNotEmpty) {
      res.add(pq.removeFirst().val);
    }
    return res;
  }

  void sortListQueue(ListQueue<Node<T>> queue) {
    List<Node<T>> list = queue.toList();
    list.sort((a, b) => b.count - a.count);
    queue.clear();
    queue.addAll(list);
  }

  void _inorder(Node<T> root, ListQueue<Node<T>> pq) {
    if (root != null) {
      _inorder(root.left, pq);
      pq.add(root);
      _inorder(root.right, pq);
    }
  }

  Node<T> rightRotate(Node<T> root) {
    Node<T> newRoot = root.left;
    root.left = newRoot.right;
    newRoot.right = root;
    return newRoot;
  }

  Node<T> leftRotate(Node<T> root) {
    Node<T> newRoot = root.right;
    root.right = newRoot.left;
    newRoot.left = root;
    return newRoot;
  }

  Node getRoot() {
    return root;
  }
}
