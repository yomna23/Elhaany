
import 'package:elha2ny/Screens/AdminScreen/AdminCubit/AdminCubit.dart';
import 'package:elha2ny/Screens/AdminScreen/AdminCubit/AdminState.dart';
import 'package:elha2ny/Screens/AdminScreen/AdminScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ControlScreen.dart';

class UserAuthentication extends StatelessWidget
{
  final int  UserIndex ;

  const UserAuthentication(this.UserIndex)  ;
  @override
  Widget build(BuildContext context) {

   return BlocConsumer<AdminCubit,AdminStates>(

      listener: (context,state){},
      builder: (context,state){

        var data = AdminCubit.get(context).unAuthenUsers[UserIndex] ;

        return Scaffold(

          backgroundColor: Color(0xFFF6E6E6),
            appBar: AppBar(
              title: Text("User Authentication",style: TextStyle(color: Colors.black,fontSize: 25,),),

              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,color: Colors.pink,),
                onPressed: (){
                },
              ),
            ),
            body:
            SingleChildScrollView(




              child: Expanded(
                  child: Column(

                   // mainAxisAlignment: MainAxisAlignment.center,


                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                            child:
                              Image(
                                width: 350.0,
                                height: 400.0,
                                image : NetworkImage('${data.Authenimage}'),

                              )



                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(child: Text('User NationalID  :',style: TextStyle(fontSize: 20.0,color: Colors.black),)),
                          )
                          ,
                          SizedBox(
                            width: 5.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(child: Text('${data.UserNationalId}',style: TextStyle(fontSize: 20.0,color: Colors.black),)),
                          ),
                        ],


                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(1, 5, 0, 5),
                            child: Expanded(child: Text('User generated code :',style: TextStyle(fontSize: 20.0,color: Colors.black),)),
                          )
                          ,
                          SizedBox(
                            width:5.0,
                          ),
                         Padding(
                           padding: const EdgeInsets.fromLTRB(1, 5, 0, 5),
                           child: Expanded(child: Text('${data.Gcode}',style: TextStyle(fontSize: 20.0,color: Colors.black),)),
                         ),
                        ],


                      ),
                      SizedBox(
                        height: 30.0,
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

                            await AdminCubit.get(context).UpdateAuthenticationFlag(flag:true, index:UserIndex );
                            Navigator.push(context,MaterialPageRoute(builder: (context)=> ControlScreen()));

                          },
                          child: Text("Accept"),
                        ),



                    ],
                  ),





              ),
            )

        );
      },



    );


  }


}