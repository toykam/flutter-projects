import 'dart:wasm';

import 'package:bloc_app/models/page_data.dart';
import 'package:bloc_app/notifiers/counter_notifier.dart';
import 'package:bloc_app/notifiers/page_notifier.dart';
import 'package:bloc_app/pages/PageTwo.dart';
import 'package:bloc_app/pages/TodoPage.dart';
import 'package:bloc_app/screen_providers/todo_screen_provider.dart';
import 'package:bloc_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CounterNotifier counterNotifier = Provider.of<CounterNotifier>(context, listen: false);
    ScreenNotifier screenNotifier = Provider.of<ScreenNotifier>(context);
    // print(counterNotifier);
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(screenNotifier.getPage.page_title),
        actions: <Widget>[
          Text(screenNotifier.getVisitedScreens.length.toString(), style: Theme.of(context).textTheme.display4,)
        ],
      ),
      body: PoppingPage(
        child: FutureBuilder(
          future: Future.delayed(Duration(milliseconds: 100)),
          builder: (context, snapshot) {
            double width;
            switch(snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                width = 0;
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.done:
                width = MediaQuery.of(context).size.width;
                break;
            }
            return AnimatedContainer(
              color: Colors.amber,
              duration: Duration(milliseconds: 1000),
              width: width,
              child: Consumer<CounterNotifier>(
                builder: (context, counter, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          'You have pushed the button this many times:',
                      ),
                      Text(
                        '${counter.getCount}',
                        style: Theme.of(context).textTheme.display4.apply(fontSizeDelta: 100),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AnimatedPadding(
                              duration: Duration(seconds: 5),
                              curve: Curves.bounceIn,
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                onPressed: () => counterNotifier.updateCount(type: 'increment'),
                                tooltip: 'Increment',
                                child: Icon(Icons.add),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                onPressed: () => counterNotifier.updateCount(type: 'decrement'),
                                tooltip: 'Decrement',
                                child: Icon(Icons.remove),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                onPressed: () => screenNotifier.changeScreen(context, PageData(page_title: 'Second Page', screen: PageTwo())),
                                // onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PageTwo())),
                                tooltip: 'Second Page',
                                child: Icon(Icons.open_in_browser),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                onPressed: () => screenNotifier.changeScreen(context, PageData(page_title: 'Todo List', screen: TodoScreenProvider())),
                                tooltip: 'Todo Page',
                                child: Icon(Icons.list),
                              ),
                            ),
                          ],
                        ),
                    ]
                  );
                },
              ),
            );
          }
        ),
      ),
    );
  }
}