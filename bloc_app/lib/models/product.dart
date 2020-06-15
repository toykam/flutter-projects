import 'dart:math';
var rng = new Random();

class Product {
  final String name;
  String _id;
  final double price;
  final String  description;
  final List imagePath;
  final String category;
  final int rating;

  Product({this.name, this.price, this.description, this.imagePath, this.category, this.rating}){
    _id = 'PR'+rng.nextInt(10000).toString();
  }

  Product.fromJson(Map<String, dynamic> product):
    name = product['name'], 
    price = product['price'], 
    description = product['description'], 
    imagePath = product['imagePath'], 
    category = product['category'],
    rating = product['rating'],
    _id = product['productId'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    '_id': _id,
    'category': category,
    'description': description,
    'imagePath': imagePath,
  };

  @override
  String toString() {
    // TODO: implement toString
    super.toString();
    return 'Product {name: $name, description: $description, id: $_id, category: $category, imapePath: ${imagePath.toString()}}';
  }
}