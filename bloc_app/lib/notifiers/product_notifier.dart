import 'dart:convert';

import 'package:bloc_app/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ProductNotifier extends ChangeNotifier {
  List<Product> _products;

  void getProducts() async {
    String productString = await rootBundle.loadString('assets/data/products.json');
    List productList = json.decode(productString);

    _products = productList.map((data) => Product.fromJson(data)).toList();
    // print(_products);
    notifyListeners();
  }

  List<Product> get getProductList => _products;

  ProductNotifier() {
    getProducts();
    print(_products);
  }
}