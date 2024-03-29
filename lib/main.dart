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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key,}) : super(key: key);
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List _userMessages = new List();
  final List _responseMessage = new List();
 // final List _messages = new List();
  var message = "hi";
  final userMessageController = TextEditingController();

  _submit() {
      
     //print(_userMessages); 
     
    
   setState(() {
    
      message = userMessageController.text;
      _userMessages.add(message);
      userMessageController.clear();
      
    }); 
     response(message);
  }

  @override
  Widget build(BuildContext context) {
    final enterMessage = Row(
      children: <Widget>[
        Expanded(
            child: TextFormField(
                controller: userMessageController,
                decoration: InputDecoration(
                    hintText: "Enter message",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(20))))),
        IconButton(icon: Icon(Icons.send), onPressed: _submit)
      ],
    );

    final userMessage = Row(
      children: <Widget>[
        new Expanded(
            child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _userMessages.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 4.0,
                margin: EdgeInsets.only(left: 300.0),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(color: Colors.white),
                  child: new ListTile(
                    title: Text(_userMessages[index]),
                  ),
                )
                //decoration: new BoxDecoration(color: Colors.blueAccent),
                );
          },
        ))
      ],
    );
    final botMessage = Row(
      children: <Widget>[
        new Expanded(
            child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _responseMessage.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 4.0,
                margin: EdgeInsets.only(right: 80.0),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(color: Colors.white),
                  child: new ListTile(
                    title: Text(_responseMessage[index]),
                  ),
                )
                //decoration: new BoxDecoration(color: Colors.blueAccent),
                );
          },
        ))
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Bot"),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height >= 775.0
            ? MediaQuery.of(context).size.height
            : 775.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            userMessage,
            botMessage,
            Expanded(
              flex: 1,
              child:Padding(
              padding: EdgeInsets.only(top: 450, right: 40.0, left: 30.0),
              child: 
              enterMessage,
            ), )
            
          ],
        ),
      )),
      // Positioned(
      //   top: 680,
      //   right: 40,
      //   child: sendButton,
      // )
    );
  }

  // Widget userMessage(BuildContext context) {
  //   return Row(children: <Widget>[
  //     ListView.builder(
  //       // padding: EdgeInsets.only(right:8.0),
  //       itemCount: _userMessages.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         return Text(userMessageController.text);
  //       },
  //     )
  //   ]);
  // }

  // Widget responseMessage(BuildContext context) {
  //   return Row(
  //     children: <Widget>[
  //       Container(
  //         margin: EdgeInsets.only(right: 80.0),
  //         //child:ListTile(),
  //         child: Text(botResponse),
  //         decoration: new BoxDecoration(color: Colors.blueGrey),
  //       )
  //     ],
  //   );
  // }
  void response(query) async {
  AuthGoogle authGoogle = await AuthGoogle(fileJson: "assets/credentials.json").build();
  Dialogflow dialogflow = Dialogflow(authGoogle: authGoogle,language: Language.english);
  AIResponse response = await dialogflow.detectIntent(message);
  setState(() {
    _responseMessage.add(response.getMessage());
  });
  print(response.getMessage());

  
   }
}
 


