import 'package:flutter/material.dart';
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
  //final List<ChatMessage> _messages = new List();
  final TextEditingController sentmessage = TextEditingController();

  _submit() {
    debugPrint(sentmessage.text);
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
              Row(
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
              )
            ],
          ),
        ));
  }
}

Widget userMessage(BuildContext context) {
  return Row(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 300.0),
        child: Text("How are you???"),
      )
    ],
  );
}

Widget responseMessage(BuildContext context) {
  return Row(
    children: <Widget>[
      Container(
          margin: EdgeInsets.only(right: 100.0),
          child: Text("I am fine,how are you? "))
    ],
  );
}
