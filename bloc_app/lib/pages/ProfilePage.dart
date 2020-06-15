import 'package:bloc_app/models/page_data.dart';
import 'package:bloc_app/notifiers/cart_notifier.dart';
import 'package:bloc_app/notifiers/page_notifier.dart';
import 'package:bloc_app/pages/CartPage.dart';
import 'package:bloc_app/pages/OrderPage.dart';
import 'package:bloc_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenNotifier _screenNotifier = Provider.of<ScreenNotifier>(context);
    CartNotifier _cartNoifier = Provider.of<CartNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        title: AppBarTitle('Profile'),
        actions: <Widget>[
          Text(_screenNotifier.getVisitedScreens.length.toString(), style: Theme.of(context).textTheme.display4,)
        ],
      ),
      body: PoppingPage(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/image.png'),
              repeat: ImageRepeat.repeat,
              colorFilter: ColorFilter.matrix([
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 225,
                0.2126, 0.7152, 0.0722, 0, 0,
                0,      0,      0,      1, 0,
              ])
            )
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('assets/images/image2.jpg'),
                        radius: 50,
                      )
                    ),
                    Text('Kabir Toyyib', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200)),
                    Text('@toykam', style: Theme.of(context).textTheme.title.apply(fontSizeDelta: 0.1)),
                  ],
                ),
              ),
              Container(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    MyListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.shopping_basket)
                      ),
                      title: Text('Orders', style: Theme.of(context).textTheme.title,),
                      subtitle: Text('All your order will be seen here.'),
                      trailing: Chip(label: Text(3.toString())),
                      onTap: () => _screenNotifier.changeScreen(context, PageData(page_title: 'Orders', screen: OrderPage())),
                    ),
                    MyListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.shopping_cart)
                      ),
                      title: Text('Cart Items', style: Theme.of(context).textTheme.title,),
                      subtitle: Text('View items you have added to cart.'),
                      trailing: Chip(label: Text(_cartNoifier.getTotalItem.toString())),
                      onTap: () => _screenNotifier.changeScreen(context, PageData(page_title: 'Orders', screen: CartPage())),
                    ),
                    MyListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.person)
                      ),
                      title: Text('Profile', style: Theme.of(context).textTheme.title,),
                      subtitle: Text('View and edit your profile.'),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () => _screenNotifier.changeScreen(context, PageData(page_title: 'Orders', screen: OrderPage())),
                    ),
                    MyListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.settings)
                      ),
                      title: Text('Settings', style: Theme.of(context).textTheme.title,),
                      subtitle: Text('Set your delivery location here.'),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () => _screenNotifier.changeScreen(context, PageData(page_title: 'Orders', screen: OrderPage())),
                    ),
                  ],
                ),
              )
            ],
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