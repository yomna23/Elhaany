







import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Center(child: Text('The Application is running',style: TextStyle(fontSize:20.0 ,fontWeight: FontWeight.bold ))) ,

      )
    );
  }
}