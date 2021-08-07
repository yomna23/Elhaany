
import 'package:conditional_builder/conditional_builder.dart';
import 'package:elha2ny/Model/UserModel.dart';
import 'package:elha2ny/Model/messageModel.dart';
import 'package:elha2ny/Screens/rating/User/Urating.dart';
import 'package:elha2ny/components/WholeAppCubit/AppCubit.dart';
import 'package:elha2ny/components/WholeAppCubit/AppStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;

  ChatDetailsScreen({
    required this.userModel,
  });

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {

        return BlocConsumer<ElhaanyCubit,ELhaanyStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                leading: IconButton(
                    icon : Icon(Icons.arrow_back_ios,color: Colors.pink,),
                    onPressed: (){
                      Navigator.pop(context) ;

                    },

                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        userModel.image,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      userModel.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: ElhaanyCubit.get(context).messages.length >= 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index)
                          {
                            var message = ElhaanyCubit.get(context).messages[index];

                            if(ElhaanyCubit.get(context).model.UId == message.senderId)
                              return buildMyMessage(message);

                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15.0,
                          ),
                          itemCount: ElhaanyCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                ),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here ...',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: Colors.pink,
                              child: MaterialButton(
                                onPressed: () {
                                  ElhaanyCubit.get(context).sendMessage(
                                    receiverId: userModel.UId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  Icons.send,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );


  }

  Widget buildMessage(MessageModel Msgmodel) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(
            10.0,
          ),
          topStart: Radius.circular(
            10.0,
          ),
          topEnd: Radius.circular(
            10.0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
        Msgmodel.text,
      ),
    ),
  );

  Widget buildMyMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.pink.withOpacity(
          .2,
        ),
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(
            10.0,
          ),
          topStart: Radius.circular(
            10.0,
          ),
          topEnd: Radius.circular(
            10.0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
        model.text,
      ),
    ),
  );
}