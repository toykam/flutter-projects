import 'product.dart';

class CartItem {

  final Product product;
  final int qty;
  final double subtotal;


  CartItem({this.product, this.qty, this.subtotal});

  CartItem.fromJson(Map<String, dynamic> json):
    product = json['item'],
    qty = json['qty'],
    subtotal = json['subtotal'];

  Map<String, dynamic> toJson(CartItem item) => {
    'product': item.product,
    'qty': item.qty,
    'subtotal': item.subtotal,
  };
}