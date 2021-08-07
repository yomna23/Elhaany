import 'package:conditional_builder/conditional_builder.dart';
import 'package:elha2ny/Model/UserModel.dart';
import 'package:elha2ny/components/WholeAppCubit/AppCubit.dart';
import 'package:elha2ny/components/WholeAppCubit/AppStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ChatDetailes.dart';
import 'package:flutter/services.dart';
class ChatsScreen extends StatelessWidget {

  final UserModel reciver;

  const ChatsScreen(this.reciver) ;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElhaanyCubit, ELhaanyStates>(
      listener: (context, state) {},
      builder: (context, state) {
       // var receiver = ElhaanyCubit.get(context).receiver ;
        return Scaffold(
          body :Padding(
            padding: const EdgeInsets.all(30.0),
            child: InkWell(
             onTap: () async {
               await ElhaanyCubit.get(context).getMessages(receiverId:  reciver.UId) ;

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatDetailsScreen(userModel:reciver)));
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35.0,
                      backgroundImage: NetworkImage(
                        '${reciver.image}',
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      '${reciver.name}',
                      style: TextStyle(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ),




        );
      },
    );
  }

}