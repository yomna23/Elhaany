import 'package:conditional_builder/conditional_builder.dart';
import 'package:elha2ny/Model/UserModel.dart';
import 'package:elha2ny/Screens/ChatScreen/ChatScreen.dart';
import 'package:elha2ny/Screens/GoogleMap/google.dart';
import 'package:elha2ny/Screens/rating/User/Urating.dart';
import 'package:elha2ny/components/WholeAppCubit/AppCubit.dart';
import 'package:elha2ny/components/WholeAppCubit/AppStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HelperCom extends StatelessWidget
{
  final UserModel helper ;

  const HelperCom( this.helper) ;



  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ElhaanyCubit,ELhaanyStates>

      (listener:(context,state){},
      builder: (context,state){
        //var reciever = ElhaanyCubit.get(context).receiver ;
        var req = ElhaanyCubit.get(context).request ;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar:AppBar(
            title:Text('Communication',style: TextStyle(color: Colors.black,fontSize: 22),),

          ) ,





          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      primary:Colors.pink,
                      padding: EdgeInsets.fromLTRB(85, 15, 85, 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // <-- Radius
                      ),
                    ),

                    onPressed: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsScreen(helper)));


                    },





                    child: Text("Chat Helper"),
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

                    onPressed: () {

                      //.push(context, MaterialPageRoute(builder: (context) =>  ChatsScreen() ));
                      Clipboard.setData(ClipboardData(text:  helper.phone)) ;

                    },

                    child: Text(" Call Helper "),
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

                    onPressed: () async {

                      Navigator.push(context,MaterialPageRoute(builder: (context)=> UserRating(helper)) );
                    },

                    child: Text("Rate Helper"),
                  ) ,








                ],



              ),
            ),
        );
        }

    );



      }









  }






