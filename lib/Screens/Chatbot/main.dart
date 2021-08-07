import 'package:elha2ny/Screens/Chatbot/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';




class MyHomePage extends StatefulWidget {


  final String title;

  const MyHomePage({required this.title}) ;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String responseMsg = '';
  BotService botService = BotService();
  TextEditingController myController = TextEditingController();
  Future<void> _incrementCounter() async {
    responseMsg = await botService.getResponse(myController.text);
    setState(() {});
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.pink,),onPressed: (){Navigator.pop(context);},),
        title: Text("ChatBot",style: TextStyle(fontSize: 25,color: Colors.black),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            Text(
              "Today, ${DateFormat("Hm").format(DateTime.now())}",
              style: TextStyle(fontSize: 20 , color: Colors.pink),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                  hintText: "Enter message here",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
           // Text('Elhaany ChatBot',style: TextStyle(color: Colors.pink),),
            Text(
              '$responseMsg',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Send',
        child: Icon(Icons.send),
      ),
    );
  }
}
