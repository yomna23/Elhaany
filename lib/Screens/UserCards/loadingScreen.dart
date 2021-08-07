

import 'package:conditional_builder/conditional_builder.dart';
import 'package:elha2ny/Model/UserModel.dart';
import 'package:elha2ny/Screens/ChatScreen/HelperComm.dart';
import 'package:elha2ny/Screens/UserCards/User_Card.dart';
import 'package:elha2ny/components/WholeAppCubit/AppCubit.dart';
import 'package:elha2ny/components/WholeAppCubit/AppStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class loadingScreen extends StatelessWidget
{

  final UserModel helper ;

  const loadingScreen(this.helper) ;

  @override
  Widget build(BuildContext context) {
  return BlocConsumer<ElhaanyCubit,ELhaanyStates>
    (listener: (context,state){
    },
    builder:(context,state){
      var req = ElhaanyCubit.get(context).request ;
       return Scaffold(

           appBar:AppBar(
             title:Text('Communication',style: TextStyle(color: Colors.black,fontSize: 22),
             ),
             leading: IconButton(
                 icon:Icon(Icons.arrow_back_ios,color:Colors.pink) ,
                 onPressed: (){
                   Navigator.pop(context);
                 }
               ),
             actions: [

               IconButton(
                   icon:Icon(Icons.remove,color:Colors.white) ,
                   onPressed: (){
                     print('the request pending  ${req.isPending}');
                     Navigator.push(context,MaterialPageRoute(builder: (context)=> HelperCom(helper)));
                   }
               ),
               IconButton(
                   icon:Icon(Icons.remove,color:Colors.white) ,
                   onPressed: (){
                     print('the request pending  ${req.isPending}');
                     Navigator.push(context,MaterialPageRoute(builder: (context)=> UserCards()));
                   }
               ),


             ],

           ) ,

           body: Center(child: CircularProgressIndicator())

       );
  }

  );

  }






}