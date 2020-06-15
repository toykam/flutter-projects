import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'FriendlyChat'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _textEditController = new TextEditingController();
  
  List<String> _messages = new List<String>();

// Function To Handle Submit
_handleSubmit(String text) {
    if (text.length > 0) {
      _messages.insert(0, text);
      setState(() {
        _messages = _messages;
        _isComposing = false;
      });
      _textEditController.clear();
    } else {
      // return SnackBar(content: Text('typr'),)
    }
  }

  _handleDismiss(int index) {
    setState(() {
      _messages.removeAt(index);
    });
  }

  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor
              ),
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  // return ChatMessage(text: _messages[index]);</Widget>
                  return Dismissible(
                    key: Key(_messages[index]),
                    onDismissed: (dismissDirection) => _handleDismiss(index),
                    child: ChatMessage(text: _messages[index]),
                  );
                },
              ),
            )
          ),
          new Divider(height: 1.0), 
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
              Expanded(child: TextField(
                controller: _textEditController,
                onSubmitted: _handleSubmit,
                decoration: InputDecoration.collapsed(hintText: 'Send a message'),
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0 ? true : false;
                  });
                },
              ),),
              IconButton(icon: Icon(Icons.send, color: Colors.amber,), onPressed: () => _isComposing ? _handleSubmit(_textEditController.text.toString()) : null)
            ],)
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.amberAccent,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.0,
                child: Center(
                  child: Text('Side Bar!'),
                ),
              )
            ],
          )
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



class ChatMessage extends StatelessWidget {
  const ChatMessage({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Text('Y'),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Sender'),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text(text),
                    ),
                  ]
                )
              ),
            ]
          )
        ),
    );
  }
}