import 'package:bloc_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({this.product});
  final Product product;
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container()
    );
  }
}

Widget _buildTopBar({String title}) {
  return Row(
    children: <Widget>[
      Text(title)
    ],
  );
}