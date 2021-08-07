

import 'package:elha2ny/Screens/AdminScreen/AdminCubit/AdminCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddCategoryScreen.dart';
import 'AdminScreen.dart';

class ControlScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page",style: TextStyle(fontSize: 25,color: Colors.black,),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.pink,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(

        decoration: BoxDecoration(

            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.5, 5],
                colors: [Colors.white, Colors.redAccent])




        ),


        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Image.asset(
                "assets/images/logotogo3.png",
                height:  400,
              ),

              ElevatedButton(

                style: ElevatedButton.styleFrom(
                  primary:Colors.pink,
                  padding: EdgeInsets.fromLTRB(85, 15, 85, 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // <-- Radius
                  ),
                ),

                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddCategoryScreen() ));


                },





                child: Text("Add Categories"),
              ) ,

              SizedBox(
                height: 40.0,
              ),

              ElevatedButton(

                style: ElevatedButton.styleFrom(
                  primary:Colors.pink,
                  padding: EdgeInsets.fromLTRB(85, 15, 85, 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // <-- Radius
                  ),
                ),

                onPressed: () async{

                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  AdminAuthenScreen() ));

                },
                child: Text("Authenticate users"), ) ,







            ],



          ),
        ),
      ),




    );
  }






}