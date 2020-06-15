import 'dart:math';

import 'package:bloc_app/models/product.dart';

var rng = new Random();
class Order {
  String _orderId;
  final String address;
  final double amount;
  final int productId;
  final List<Product> items;

  Order({this.address, this.amount, this.productId, this.items}) {
    _orderId = 'ORD'+rng.nextInt(10000).toString();
  }

  get getOrderId => _orderId;
}