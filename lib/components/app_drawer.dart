import 'package:elha2ny/Network/Local/Cache.dart';
import 'package:elha2ny/Screens/ChatScreen/ChatScreen.dart';
import 'package:elha2ny/Screens/ChatScreen/CommunicationScreen.dart';
import 'package:elha2ny/Screens/Chatbot/main.dart';
import 'package:elha2ny/Screens/PendingResponses/PendingResponse.dart';
import 'package:elha2ny/Screens/Profile/Profile_Page.dart';
import 'package:elha2ny/Screens/Welcome/welcome_screen.dart';
import 'package:elha2ny/components/WholeAppCubit/AppCubit.dart';
import 'package:elha2ny/components/WholeAppCubit/AppStates.dart';
import 'package:elha2ny/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    var model = ElhaanyCubit.get(context).model ;
    var profileImage = ElhaanyCubit.get(context).Profileimage ;
    return BlocConsumer<ElhaanyCubit,ELhaanyStates>(
      listener: (context,state){

      },
      builder: (context,state){

        return Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width -
              (MediaQuery.of(context).size.width * 0.2),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.0,
                  ),
                  height: 170.0,
                  color: _theme.primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[



                      SizedBox(
                        height: 7.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          CircleAvatar(
                          radius: 30.0,
                          backgroundImage: profileImage== null ? NetworkImage('${model.image}')  : FileImage(profileImage) as ImageProvider,


                        ),
                          Column(
                            children: [
                              Text(
                                "${model.name}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "${model.phone}",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 15.0,
                                ),
                              )
                            ],
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    //return LoginScreen();
                                    return UserProfilePage();
                                  }));
                            },
                            child: Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: ListView(children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserProfilePage()));
                        },
                        child: ListTile(
                          leading: Icon(Icons.person,),
                          title: Text(
                            "Profile Page",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage(title: 'Chatbot')));
                        },
                        child: ListTile(
                          leading: Icon(Icons.chat_bubble_outline),
                          title: Text(
                            "ChatBot",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {

                         await ElhaanyCubit.get(context).getPendingResponse() ;
                         await ElhaanyCubit.get(context).loopPendngUserRequest() ;
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PendingResponse()));
                        },

                        child: ListTile(
                          leading: Icon(Icons.notification_important_outlined),
                          title: Text(
                            "Notification",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));*/
                        },

                        child: ListTile(
                          leading: Icon(Icons.adjust_outlined),
                          title: Text(
                            "About",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed: () async {

                          // Navigator.push(context, MaterialPageRoute(builder: (context) =>WelcomeScreen())) ;
                          await CacheHelper.signOut(key: uId.toString()) ;
                          print('apppppppppp drawerrrr');
                          print(uId.toString()) ;
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>WelcomeScreen())) ;



                        },
                        child: ListTile(
                          leading: Icon(Icons.logout),
                          title: Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        );

      },
    );


  }



}