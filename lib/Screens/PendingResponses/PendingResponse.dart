import 'dart:convert';

import 'package:elha2ny/Screens/ChatScreen/CommunicationScreen.dart';
import 'package:elha2ny/Screens/HomePage/Home_Page.dart';
import 'package:elha2ny/Screens/NotificationScreen/notificationPage.dart';
import 'package:elha2ny/components/WholeAppCubit/AppCubit.dart';
import 'package:elha2ny/components/WholeAppCubit/AppStates.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


class PendingResponse extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var pendinguser = ElhaanyCubit.get(context).usermodel.toList() ;
    var pendingReq = ElhaanyCubit.get(context).pendingResponses.toList();
    var model = ElhaanyCubit.get(context).model ;

    return BlocConsumer<ElhaanyCubit,ELhaanyStates>(
      listener: (context,state){},
      builder: (context,state){

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.pink,),
              onPressed: (){
                Navigator.pop(context) ;

              },),
            title: Text('Requests',style: TextStyle(fontSize: 25, color: Colors.black),),

          ),
          body: SafeArea(

              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    for(int i=0 ; i<pendingReq.length ; i++)
                      Card(color: Colors.white,


                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25,),
                          child: Row(
                            children: [

                              Padding(
                                  padding :EdgeInsets.all(20),



                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage('${pendinguser[i].image}'),
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${pendinguser[i].name}",
                                    style: TextStyle(

                                      letterSpacing: 1.25,
                                      fontSize: 20,


                                    ),),
                                  Text("Rating: ${pendinguser[i].rate}  ✩",
                                      style: TextStyle(


                                        fontSize: 13, )

                                  ),
                                  Text("${pendingReq[i].Distance}  meters Away",
                                      style: TextStyle(


                                        fontSize: 13,
                                      )),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(25, 12, 5, 3),
                                child: Column(
                                  children: [
                                    ElevatedButton(


                                      style: ElevatedButton.styleFrom(


                                        primary: Colors.pink,

                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20), // <-- Radius
                                        ),
                                      ),

                                      onPressed: () async {
                                        await ElhaanyCubit.get(context).UpdateRequestnoti(pendingReq[i].Uid, pendingReq[i].catName, pendingReq[i].Desc, pendingReq[i].time, pendingReq[i].latitude,
                                            pendingReq[i].longitude, pendingReq[i].ReqId,false, model.UId, pendingReq[i].Distance) ;

                                        Navigator.push(context,MaterialPageRoute(builder: (context) => CommunicationScreen(pendinguser[i]) ));
                                      },
                                      child: Text("Accept"), ),
                                    ElevatedButton(


                                      style: ElevatedButton.styleFrom(


                                        primary: Colors.pink,

                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20), // <-- Radius
                                        ),
                                      ),

                                      onPressed: () async {
                                        await ElhaanyCubit.get(context).UpdateRequestnoti(pendingReq[i].Uid, pendingReq[i].catName, pendingReq[i].Desc, pendingReq[i].time, pendingReq[i].latitude,
                                            pendingReq[i].longitude, pendingReq[i].ReqId,false, '', pendingReq[i].Distance) ;

                                        Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));
                                      },
                                      child: Text("Ignore"), ),
                                  ],
                                ),
                              ),





                            ],


                          )

                      ),


                  ],
                ),
              )


          ),
        );

      },
    );

  }}

