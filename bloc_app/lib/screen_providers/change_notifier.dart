import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenChangeNotifierProvider extends StatelessWidget {

  ScreenChangeNotifierProvider({Key key, this.notifier, this.child}): super(key: key);

  final ChangeNotifier notifier;
  final Widget child;

 
  
  @override
  Widget build(BuildContext context) {
    print(notifier);
    return ChangeNotifierProvider(
      create: (BuildContext context) => notifier,
      child: child,
    );
  }
}