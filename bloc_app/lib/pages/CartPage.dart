import 'package:bloc_app/notifiers/cart_notifier.dart';
import 'package:bloc_app/notifiers/page_notifier.dart';
import 'package:bloc_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenNotifier _screenNotifier = Provider.of<ScreenNotifier>(context);
    CartNotifier _cartNotifier = Provider.of<CartNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        title: AppBarTitle('Cart Items'),
        actions: <Widget>[
          Text(_screenNotifier.getVisitedScreens.length.toString(), style: Theme.of(context).textTheme.display4,)
        ],
      ),
      floatingActionButton: RaisedButton(
        color: Colors.lightGreen,
        splashColor: Colors.white,
        onPressed: (){},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.shopping_basket),
            SizedBox(width: 10,),
            Text('Order Now', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),)
          ],
        ),
      ),
      body: PoppingPage(
        child: Hero(
          tag: 'profile',
          child: (_cartNotifier.getCartItems.length > 0) ? Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                color: Colors.red,
                child: Text('N '+_cartNotifier.getCartTotalPrice.toString(), style: TextStyle(color: Colors.white),),
              ),
              ListView(
                children: _cartNotifier.getCartItems.map((f) => CartItemTile(cartItem: f,)).toList(),
              ),
            ],
          )  : Center(
            child: Text('No Item Found In cart...')
          ),
        ),
      )
    );
  }
}

// onWillPop: () async => _screenNotifier.onBackPressed(context)

// if (screenNotifier.getVisitedScreens.length > 0) {
//   screenNotifier.popScreen();
//   return Future.value(false);
// } else {
//   bool close = await screenNotifier.onBackPressed(context);
//   return Future.value(close);
// }

