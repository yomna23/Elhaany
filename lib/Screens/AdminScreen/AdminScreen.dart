

import 'package:elha2ny/Screens/AdminScreen/UserAuthentication.dart';
import 'package:elha2ny/components/WholeAppCubit/AppCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AdminCubit/AdminCubit.dart';
import 'AdminCubit/AdminState.dart';

class AdminAuthenScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

            return BlocConsumer<AdminCubit,AdminStates>(
              listener: (context,state){},
              builder: (context,state){
              var UnAuthenUser = AdminCubit.get(context).unAuthenUsers;
              //var y = AdminCubit.get(context).unAuthenUsers.length ;
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Waiting List",style: TextStyle(color: Colors.black,fontSize: 25,),),

                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios,color: Colors.pink,),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: SingleChildScrollView(
                      child: Column(

                        children: [
                          SizedBox(
                            width: 30.0,
                          ),

                          for(int i=0 ; i<UnAuthenUser.length ; i++)
                            Column(

                              children: [
                                SizedBox(height: 20.0,),
                                Row(
                                children: [

                                  Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${UnAuthenUser[i].name}' , style: TextStyle(fontSize: 20.0,color:Colors.black,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [

                                      IconButton(
                                        icon: Icon(Icons.arrow_forward_ios_sharp,color: Colors.pink,size: 30.0,),
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserAuthentication(i)));

                                        },

                                       )

                                      ],
                                    ),
                                  )

                                ],
                          ),
                              ],
                            )

                        ],
                      ),
                    ),
                  ),
                );

              },

            );






  }


}