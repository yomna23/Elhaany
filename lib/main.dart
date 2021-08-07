
import 'package:bloc/bloc.dart';
import 'package:elha2ny/Observer.dart';
import 'package:elha2ny/Screens/HomePage/Components/body.dart';
import 'package:elha2ny/Screens/Signup/Cubit/SignUpCubit.dart';
import 'package:elha2ny/Screens/Welcome/welcome_screen.dart';
import 'package:elha2ny/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'Network/local/Cache.dart';
import 'Screens/AdminScreen/AdminCubit/AdminCubit.dart';
import 'Screens/HomePage/Home_Page.dart';
import 'Screens/Login/Cubit/LoginCubit.dart';
import 'Screens/Login/Cubit/LoginState.dart';
import 'Screens/rating/User/Urating.dart';
import 'components/WholeAppCubit/AppCubit.dart';
import 'components/WholeAppCubit/AppStates.dart';


// 7atha fe el staeful class
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
// Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);




    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('123');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ));
    }});


  Bloc.observer = MyBlocObserver();

  Widget widget ;
 await CacheHelper.GetData(key: 'uId').then((value) => uId = value )  ;
  print('hey that is User ID');
  print(uId.toString());


 if(uId !=null)
    {
      widget = HomePage();

    }else{
    widget = WelcomeScreen() ;
 }

  runApp(MyApp(
    startWigget : widget

  ));
}



class MyApp extends StatelessWidget {

  Widget startWigget ;
  MyApp({required this.startWigget}) ;

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers:
        [

          BlocProvider(
            create: (context) => ElhaanyCubit()..getUserData()..getMyLocation()..getCategories(),
          ),

        BlocProvider(
        create: (context) => RegisterCubit()..getToken(),
             ),

          BlocProvider(
            create: (context) => loginCubit()..getToken(),
          ),


         BlocProvider(
           create:(context) => AdminCubit()..getAllunthenUser(),
         ),





        ]
        ,
      child : BlocConsumer<ElhaanyCubit,ELhaanyStates>
        (
          listener: (context,state){


          },
          builder: (context,state){


                  //ElhaanyCubit.get(context).getUserData();
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Elhaany',
                    theme: ThemeData(
                      primaryColor: kPrimaryColor,
                      primarySwatch: Colors.pink,
                      scaffoldBackgroundColor: Colors.white,
                      appBarTheme: AppBarTheme(

                        color: Colors.white
                      )

                    ),
                    home: startWigget ) ;}
            ),

      );





  }






}