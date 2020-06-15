import 'package:bloc_app/notifiers/page_notifier.dart';
import 'package:bloc_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenNotifier _screenNotifier = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        title: AppBarTitle('Cart'),
        actions: <Widget>[
          Text(_screenNotifier.getVisitedScreens.length.toString(), style: Theme.of(context).textTheme.display4,)
        ],
      ),
      body: PoppingPage(
        child: Hero(
          tag: 'Orders',
          child: Column(
            children: <Widget>[
              Container(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Container(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: CircleAvatar(
                          child: Icon(Icons.shopping_basket)
                        ),
                        title: Text('Orders', style: Theme.of(context).textTheme.title,),
                        subtitle: Text('All your order will be seen here.'),
                        trailing: Icon(Icons.arrow_right),
                      ),
                    ),
                    Container(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: CircleAvatar(
                          child: Icon(Icons.shopping_cart)
                        ),
                        title: Text('Cart Items', style: Theme.of(context).textTheme.title,),
                        subtitle: Text('View items you have added to cart.'),
                        trailing: Icon(Icons.arrow_right),
                      ),
                    ),
                    Container(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: CircleAvatar(
                          child: Icon(Icons.person)
                        ),
                        title: Text('Profile', style: Theme.of(context).textTheme.title,),
                        subtitle: Text('View and edit your profile.'),
                        trailing: Icon(Icons.arrow_right),
                      ),
                    ),
                    Container(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: CircleAvatar(
                          child: Icon(Icons.settings)
                        ),
                        title: Text('Settings', style: Theme.of(context).textTheme.title,),
                        subtitle: Text('Set your delivery location here.'),
                        trailing: Icon(Icons.arrow_right),
                      ),
                    ),
                    Container(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: CircleAvatar(
                          child: Icon(Icons.person)
                        ),
                        title: Text('Profile', style: Theme.of(context).textTheme.title,),
                        subtitle: Text('View and edit your profile.'),
                        trailing: Icon(Icons.arrow_right),
                      ),
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