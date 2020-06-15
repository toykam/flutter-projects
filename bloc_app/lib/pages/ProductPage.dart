import 'package:bloc_app/models/cart_item.dart';
import 'package:bloc_app/models/page_data.dart';
import 'package:bloc_app/models/product.dart';
import 'package:bloc_app/notifiers/cart_notifier.dart';
import 'package:bloc_app/notifiers/page_notifier.dart';
import 'package:bloc_app/notifiers/product_notifier.dart';
import 'package:bloc_app/pages/CartPage.dart';
import 'package:bloc_app/pages/ProductDetail.dart';
import 'package:bloc_app/pages/ProfilePage.dart';
import 'package:bloc_app/widgets/product_search_delegate.dart';
import 'package:bloc_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductNotifier _productNotifier = Provider.of<ProductNotifier>(context);
    CartNotifier _cartNotifier = Provider.of<CartNotifier>(context);
    ScreenNotifier _pageNotifier = Provider.of<ScreenNotifier>(context);

    List<Product> _products = _productNotifier.getProductList;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent[200],
        title: AppBarTitle('S:Market'),
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.shopping_cart), 
                  onPressed: () => _pageNotifier.changeScreen(context, PageData(page_title: 'Cart Items', screen: CartPage()))
                ),
                (_cartNotifier.getCartItems.length > 0) ? Text(_cartNotifier.getCartItems.length.toString()) : Text(''),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () => _pageNotifier.changeScreen(context, PageData(page_title: 'Profile', screen: ProfilePage())),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: () => showSearch(context: context, delegate: ProductSearchDelegate())
          ),
        ],
      ),
      body: PoppingPage(
        child: (_products == null) ?
        Center(
          child: CircularProgressIndicator(),
        ) :
        ListView(
          children: _buildProductList(_products, context),
        )
      ),
    );
  }
}

List<Widget> _buildProductList(List<Product> products, BuildContext context) {
  return products.map((Product product) => ProductTile(onClick: () {
    displayProduct(product, context);
  }, product: product,)).toList();
}

displayProduct(Product product, BuildContext context) async {
  CartNotifier _cartNotifier = Provider.of<CartNotifier>(context, listen: false);
  TextEditingController _qtyController = TextEditingController();
  
  return await showDialog(
    barrierDismissible: false,
    useRootNavigator: false,
    context: context,
    child: SingleChildScrollView(
      child: AlertDialog(
        actions: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ProductDetailButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.close),
                    SizedBox(width: 10),
                    Text('Close')
                  ],
                ), 
                onClick: () async {
                  Navigator.of(context).pop();
                  // await showMenu(context: context, position: RelativeRect.fill, items: [
                  //   PopupMenuItem(child: Text('Hello How are you'))
                  // ]);
                },
                color: Colors.red,
              ),
              SizedBox(width: 10),
              ProductDetailButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_shopping_cart),
                    SizedBox(width: 10),
                    Text('Add to cart')
                  ],
                ), 
                onClick: (){
                  int qty = int.parse(_qtyController.text);
                  double subtotal = product.price * qty;
                  CartItem cartItem = CartItem(product: product, qty: qty, subtotal: subtotal);
                  _cartNotifier.addToCart(cartItem);
                  Navigator.of(context).pop();
                },
                color: Colors.orange,
              ),
            ],
          )
        ],
        contentPadding: const EdgeInsets.all(4.0),
        titlePadding: const EdgeInsets.all(4.0),
        title: Text(product.name, textAlign: TextAlign.start,),
        content: DecoratedMainContainer(
          child: Column(
            children: <Widget>[
              ProductGallery(productImages: product.imagePath),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RatingWidget(rating: product.rating,),
                  Text('₦'+product.price.toString(), style: Theme.of(context).textTheme.display4,),
                  Chip(label: Text(product.category, textAlign: TextAlign.justify,),),
                  SizedBox(height: 10),
                  Text(product.description),
                  SizedBox(height: 10),
                ],
              ),
              TextField(
                onTap: () => FocusNode(),
                controller: _qtyController,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Quantity',
                ),
              ),
            ],
          ),
        ),
      ),
    )
  );
}