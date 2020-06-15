import 'package:bloc_app/models/cart_item.dart';
import 'package:flutter/widgets.dart';

class CartNotifier extends ChangeNotifier {

  List<CartItem> _cartItems = [];
  double _totalPrice = 0;
  int _totalItem = 0;

  List<CartItem> get getCartItems => _cartItems;

  int get getTotalItem => _totalItem;

  void addToCart(CartItem product) {
    _cartItems.add(product);
    syncronize();
  }

  void removeItem(CartItem product) {
    _cartItems.remove(product);
    syncronize();
  }

  void syncronize() {
    _totalPrice = 0;
    _totalItem = _cartItems.length;
    _cartItems.forEach((f) {
      _totalPrice += f.subtotal;
    });
    notifyListeners();
  }


  double get getCartTotalPrice => _totalPrice;

}