import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:elha2ny/Model/UserModel.dart';
import 'package:elha2ny/Screens/HomePage/Home_Page.dart';
import 'package:elha2ny/components/RadioBox%20-%20Copy.dart';
import 'package:elha2ny/components/RoundedProfileField.dart';
import 'package:elha2ny/components/WholeAppCubit/AppCubit.dart';
import 'package:elha2ny/components/WholeAppCubit/AppStates.dart';
import 'package:elha2ny/components/rounded_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elha2ny/components/appbar_widget.dart';
import 'package:elha2ny/components/button_widget.dart';
import 'package:elha2ny/components/numbers_widget.dart';
import 'package:elha2ny/components//profile_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';



class profilepage  extends StatelessWidget {

  var name = TextEditingController();
  var phone = TextEditingController();
  var adress = TextEditingController();
  var skills = TextEditingController();
  var password = TextEditingController() ;



  @override
  Widget build(BuildContext context) {


    return BlocConsumer<ElhaanyCubit,ELhaanyStates>(
      listener: (context,state){

         if(state is UpdateSuccessState)
           {
             Fluttertoast.showToast(
               msg: "your data updated successfuly",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.CENTER,

             );

             Navigator.push(context, MaterialPageRoute(
                 builder: (context) => HomePage()));
           }
       if(state is UpdateErrorState)
        {

          Fluttertoast.showToast(
            msg: "something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,

          );
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => profilepage()));

        }
      },
      builder: (context,state){
        var model = ElhaanyCubit.get(context).model;
        var profileImage = ElhaanyCubit.get(context).Profileimage ;
        var formkey= GlobalKey<FormState>();

        name.text = model.name ;
        phone.text = model.phone ;
        adress.text = model.address ;
       
         var values = ElhaanyCubit.get(context).catModel.toList() ;
         var firstValue = values[0].catname ;
         bool value = false ;

        return Scaffold(
          backgroundColor: Color(0xFFF6E6E6),
          body: Form(
            key: formkey,
            child: Container(

              child: ListView(

                children: [
                  if(state is UpdateLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(height: 20,),

                  Center(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            if(ElhaanyCubit.get(context).Profileimage !=null)
                              Container(
                                child:
                                     CircleAvatar(
                                         backgroundImage:FileImage(profileImage)
                                     ),



                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 4,
                                      color: Theme.of(context).scaffoldBackgroundColor),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 10))
                                  ],
                                  shape: BoxShape.circle,


                                )),
                            if(ElhaanyCubit.get(context).Profileimage ==null)
                               Container(
                                child:
                                CircleAvatar(
                                    backgroundImage: NetworkImage('${model.image}')
                                ),


                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 4,
                                      color: Theme.of(context).scaffoldBackgroundColor),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 10))
                                  ],
                                  shape: BoxShape.circle,



                                )),
                          ],
                        ),

                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Colors.pink,
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  await ElhaanyCubit.get(context).getImageee();

                                },
                                icon: Icon(Icons.camera_alt_rounded),

                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Center(

                      child: Column(
                        children: [

                            Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                 TextButton(
                                  child: Text('save photo'),
                                  onPressed: () async{

                                    await ElhaanyCubit.get(context).uploadProfileImage(name: name.text, phone: phone.text, address: adress.text);

                                  },


                                ),
                                //LinearProgressIndicator()
                              ],
                            ),
                          ),
                        ],
                      ),

                  )


                  ,const SizedBox(height: 5),
                  Column(
                    children: [
                      Text(
                        "${model.name}",

                        //${model.name}
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,

                            color:Colors.black),

                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${model.email}",

                        //${model.email}
                        style: TextStyle(color: Colors.black),

                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Center(),
                  const SizedBox(height: 5),
                  NumbersWidget(rate: model.rate,),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        RoundedProfileField(
                          valid: (value){
                            if (value!.isEmpty)
                              return 'name must not be empty';
                            else
                              return null;


                          },
                          keyboard: TextInputType.name,
                          suff: Icons.edit,
                          onPressSuffix: () {},
                          hintText:'Name',

                          cont: name,
                        ),
                        RoundedProfileField(

                          valid: (value){
                            if (value!.isEmpty)
                              return 'address must not be empty';
                            else
                              return null;


                          },
                          keyboard: TextInputType.text,
                          suff: Icons.edit,
                          onPressSuffix: () {},
                          hintText: 'Address',
                          //${model.address}
                          cont: adress,
                        ),
                        RoundedProfileField(

                          valid:(value){
                            if (value!.isEmpty)
                              return 'phone must not be empty';
                            else if(value.length <11 || value.length > 11)
                              return 'phone must not be 11 characters';
                            else
                              return null;


                          },
                          keyboard: TextInputType.phone,
                          suff: Icons.edit,
                          onPressSuffix: () {},
                          hintText:'Phone',
                          //${model.phone}
                          cont: phone,
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(

                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: DropdownButton<String>(
                            value: '${model.skill}',
                            isExpanded: true,
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                            underline: Container(
                              height: 2,
                              color: Colors.pink,
                            ),
                            onChanged: (String? newValue) {
                            }
                            ,
                            items: <String>[
                              '${model.skill}'

                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,

                          child: IconButton(icon: Icon(Icons.edit),onPressed: (){
                             ElhaanyCubit.get(context).FillCheckedList() ;
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {

                                  return AlertDialog(
                                    title: Text("Chage Skills"),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [


                                      for (int i=0;i<values.length;i++)
                                        CheckboxListTile(
                                          title:Text('${values[i].catname}'),

                                          selected: ElhaanyCubit.get(context).isChecked[i],
                                          value: ElhaanyCubit.get(context).isChecked[i],
                                          onChanged: (bool? value) {
                                            ElhaanyCubit.get(context).changeCheckedValue(value!,i);
                                          },


                                        ),


                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {

                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Close")),
                                    ],
                                  );
                                });





                          },))




                    ],
                  ),



                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 50, 25, 20),
                    child: ElevatedButton(


                      style: ElevatedButton.styleFrom(


                        primary: Colors.pink,
                        padding: EdgeInsets.fromLTRB(85, 20, 85, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // <-- Radius
                        ),
                      ),

                      onPressed: () async{
                       if(formkey.currentState!.validate()) {
                         await ElhaanyCubit.get(context).updateUserData(
                             name: name.text,
                             phone: phone.text,
                             address: adress.text);

                       }
                      },
                      child: Text("Save Changes"), ),
                  ) ,


                ],
              ),
            ),
          ),
        );


      },



    );

  }
}