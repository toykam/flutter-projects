import 'package:bloc_app/models/order.dart';
import 'package:flutter/widgets.dart';

class OrderNotifier extends ChangeNotifier {

  List<Order> _orders = [];


  List<Order> get getOrders => _orders;

  void addToOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  void removeFromOrder(String id) {
    _orders.removeWhere((Order test) => test.getOrderId == id);
    print(_orders);
  }
  

}