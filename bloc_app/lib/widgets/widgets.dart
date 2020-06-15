import 'dart:typed_data';

import 'package:bloc_app/models/cart_item.dart';
import 'package:bloc_app/models/product.dart';
import 'package:bloc_app/notifiers/cart_notifier.dart';
import 'package:bloc_app/notifiers/page_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarTitle extends StatelessWidget {
  AppBarTitle(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.display4);
  }
}



class MyListTile extends StatelessWidget {

  MyListTile({this.title, this.subtitle, this.leading, this.trailing, this.onTap});

  final Widget title;
  final Widget subtitle;
  final Widget leading;
  final Widget trailing;
  final Function onTap;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.all(
          Radius.circular(30.0)
        )
      ),
      child: InkWell(
        splashColor: Colors.white,
        hoverColor: Colors.white,
        onTap: onTap,
        child: ListTile(
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
        ),
      ),
    );
  }
}

class PoppingPage extends StatelessWidget {
  PoppingPage({this.child});
  
  final Widget child;
  @override
  Widget build(BuildContext context) {
    ScreenNotifier _screenNotifier = Provider.of<ScreenNotifier>(context);
    return WillPopScope(
      child: DecoratedMainContainer(child: child), 
      onWillPop: () => _screenNotifier.onBackPressed(context),
    );
  }
}

class DecoratedMainContainer extends StatelessWidget {
  DecoratedMainContainer({@required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: child,
    );
  }
}


class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) => Center(
    child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Container(
              height: animation.value,
              width: animation.value,
              child: child,
            ),
        child: child),
  );
}


class ProductTile extends StatelessWidget {
  ProductTile({@required this.onClick, @required this.product});

  final Product product;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 3.0),
      decoration: BoxDecoration(
        color: Colors.lightGreenAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0)
        )
      ),
      child: GestureDetector(
        onTap: onClick,
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: CircleAvatar(
            maxRadius: 50,
            minRadius: 30,
            child: Hero(
              tag: 'prod',
              child: ImagePreloader(
                url: product.imagePath[0]
              )
              // Image.network(product.imagePath[0]),
            )
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(product.name, style: TextStyle(), textAlign: TextAlign.start,),
              Text('₦'+product.price.toString(), textAlign: TextAlign.start,),
            ],
          ),
          subtitle: RatingWidget(rating: product.rating,),
        ),
      ),
    );
  }
}


class RatingWidget extends StatelessWidget {
  RatingWidget({this.rating});
  final int rating;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          StarWidget(selected: rating >= 1,),
          StarWidget(selected: rating >= 2,),
          StarWidget(selected: rating >= 3,),
          StarWidget(selected: rating >= 4,),
          StarWidget(selected: rating >= 5,),
        ]
      ),
    );
  }
}

class StarWidget extends StatelessWidget {
  StarWidget({this.selected, this.rate});
  final bool selected;
  final int rate;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print(rate),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: (selected) ? Icon(Icons.star, color: Colors.amber, size: 15,) : Icon(Icons.star, size: 15),
      ),
    );
  }
}


class ProductDetailButton extends StatelessWidget {
  ProductDetailButton({this.color, this.child, this.onClick});
  final Color color;
  final Widget child;
  final Function onClick;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onClick,
      child: child,
      splashColor: Colors.green,
      fillColor: color,
      padding: const EdgeInsets.all(8.0),
      elevation: 2,
      shape: StadiumBorder(),
    );
  }
}


class CartItemTile extends StatelessWidget {
  CartItemTile({this.cartItem});
  final CartItem cartItem;
  @override
  Widget build(BuildContext context) {
    CartNotifier _cartNotifier = Provider.of<CartNotifier>(context);
    return InkWell(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: CircleAvatar(
          child: ImagePreloader(url: cartItem.product.imagePath[0])
          // Image.network(cartItem.product.imagePath[0])
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cartItem.product.name, style: Theme.of(context).textTheme.title,),
            Text('N '+cartItem.product.price.toString()),
          ]
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Quantity: '+cartItem.qty.toString()),
            Text('Subtotal: '+cartItem.subtotal.toString()),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.remove_shopping_cart), 
          onPressed: () {
            _cartNotifier.removeItem(cartItem);
          }
        ),
      ),
    );
  }
}



class ProductGallery extends StatefulWidget {
  ProductGallery({@required this.productImages});
  final List productImages;
  @override
  _ProductGalleryState createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery> {
  String currentImageUrl;
  List images;
  int selectedImageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images = widget.productImages;
    currentImageUrl = images[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CircleAvatar(
                maxRadius: 100, minRadius: 50,
                child: 
                ImagePreloader(
                  url: currentImageUrl
                ),
                // Image.network(currentImageUrl, height: 400, width: 400,),
              ),
            ],
          ),
          Wrap(
            children: images.map(
              (image) {
                return GestureDetector(
                    onTap: () => setState((){
                      currentImageUrl = image;
                      selectedImageIndex = images.indexOf(image);
                    }
                  ),
                  child: LimitedBox(
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: (selectedImageIndex == images.indexOf(image)) ? Colors.lightGreen : Colors.black,
                          width: 2
                        )
                      ),
                      child: ImagePreloader(
                        url: image,
                      )
                      // Image.network(image)
                    ),
                    maxHeight: 60,
                    maxWidth: 60,
                  ),
                );
              }
            ).toList(),
          ),
        ],
      ),
    );
  }
}


class ImagePreloader extends StatelessWidget {
  ImagePreloader({@required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => Image.asset('assets/images/loading.gif')
    );
  }
}