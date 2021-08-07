import 'dart:convert';

import 'package:elha2ny/Screens/ChatScreen/HelperComm.dart';
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
import '../loadingScreen.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


class userCard extends StatelessWidget {




  String constructFCMPayload(String token) {
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',

      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification () was created via FCM!',
      },
    });
  }


  Future<void> sendPushMessage() async {

    String token = '' ;
     await FirebaseMessaging.instance.getToken().then((value) => token = value.toString()) ;
        //"ewkjAjFtSUGWiCFeIK8J1_:APA91bErteclOIRnLt6oCGq1Uv-O9JPNdF3JydVoRXRL8i6sdr-NeYCy7BjWdsUqhjNj_G-XpjR5VNtHXVvFI67AUkEczdyBsYgMu_4tWB5MJcd7KqZAu7G1gIeMFYZ7TFI1PolrvGhg"; //await FirebaseMessaging.instance.getToken() as String;

    print(token);

    if (token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/v1/projects/elha-ny/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=AAAAXeZ7bSE:APA91bEknp_bXJ1oHqC2MGGbVii9b4GCirzDTxHOTswSi2b66tcchj-GLWB_diKt_9ztlKyijr8CFYx0mHmfDVUC8PPLv1OVU81y-CrCmD38BoVcZexa2QyVuAGpfgk0i777vSzQ2acx'


        },
        body:jsonEncode({
          'to': token,
          'data': {
            'via': 'FlutterFire Cloud Messaging!!!',

          },
          'notification': {
            'title': 'Hello FlutterFire!',
            'body': 'This notification () was created via FCM!',
          },
        }) ,
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {

   return BlocConsumer<ElhaanyCubit,ELhaanyStates>(
      listener: (context,state){},
      builder: (context,state){
       var Helpers = ElhaanyCubit.get(context).AvailableHelpers.toList() ;
       var Distance = ElhaanyCubit.get(context).distanceDifference.toList() ;
       var req = ElhaanyCubit.get(context).RequestId ;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
             leading: IconButton(
               icon: Icon(Icons.arrow_back_ios,color: Colors.pink,)
               ,
               onPressed: (){
                 Navigator.pop(context) ;
               },
             ),
            title: Text('Helpers',style:TextStyle(fontSize: 25,color: Colors.black)),
            actions: [
              TextButton(onPressed: (){
                ElhaanyCubit.get(context).RemoveRequest(req) ;

                Navigator.push(context, MaterialPageRoute(builder:(context) => HomePage())) ;

              }, child:Text('Cancel', style: TextStyle(fontSize: 16.0,color: Colors.pink),))
            ],
          ),
          body: SafeArea(

              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                 for(int i=0 ; i< Helpers.length ; i++)
                    Card(color: Colors.white,


                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25,),
                        child: Row(
                          children: [

                            Padding(
                                padding :EdgeInsets.all(20),



                                child: CircleAvatar(
                                  backgroundImage: NetworkImage('${Helpers[i].image}'),

                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${Helpers[i].name}",
                                  style: TextStyle(


                                    letterSpacing: 1.25,
                                    fontSize: 20,



                                  ),),
                                Text("Rating: ${Helpers[i].rate} ✩",
                                    style: TextStyle(


                                      fontSize: 13,
                                    )

                                ),
                                Text("${Distance[i]}  meters Away",
                                    style: TextStyle(


                                      fontSize: 13,
                                    )),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 12, 5, 3),
                              child: ElevatedButton(


                                style: ElevatedButton.styleFrom(


                                  primary: Colors.pink,

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20), // <-- Radius
                                  ),
                                ),

                                onPressed: () async {

                                  //ElhaanyCubit.get(context).CreateRequest(Uid: uId , catName: dropDownValue, Desc:Desc.text, time:DateTime.now(), latitude:latitude, longitude: longitude);
                                  await ElhaanyCubit.get(context).UpdateRequest(true,Helpers[i].UId,Distance[i]) ;

                                 // await sendPushMessage() ;
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=> loadingScreen(Helpers[i])));
                                },
                                child: Text("Send"), ),
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

