import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat bot",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Chat bot'),
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
  final List _messages = new List();
  var message="How are you";
  final TextEditingController sentmessage = TextEditingController();

  _submit() {
    debugPrint(sentmessage.text);
  setState(() {
     message = sentmessage.text;
  });
    _messages.add(sentmessage.text);
    print("Element in the array:$_messages");
    _messages.clear();
    sentmessage.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new Container(
          child: Column(
            children: <Widget>[
              Expanded(child: userMessage(context)),
              Expanded(child: responseMessage(context)),
              enterMessage(context),
            ],
          ),
        ));
  }

  Widget userMessage(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 300.0),
          child: Text(message),
          decoration: new BoxDecoration(color: Colors.blueAccent),
        )
      ],
    );
  }

  Widget responseMessage(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 80.0),
          //child:ListTile(),
          child: Text("I am fine and You???"),
          decoration: new BoxDecoration(color: Colors.blueGrey),
        )
      ],
    );
  }

  Widget enterMessage(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: TextFormField(
                controller: sentmessage,
                decoration: InputDecoration(
                    hintText: "Enter message",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(20))))),
        IconButton(icon: Icon(Icons.send), onPressed: _submit)
      ],
    );
  }
}
