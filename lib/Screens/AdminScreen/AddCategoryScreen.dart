
import 'package:elha2ny/Screens/AdminScreen/AdminCubit/AdminCubit.dart';
import 'package:elha2ny/Screens/AdminScreen/AdminCubit/AdminState.dart';
import 'package:elha2ny/components/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ControlScreen.dart';

class AddCategoryScreen extends StatelessWidget
{

  var formkey= GlobalKey<FormState>();
  var Category = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AdminCubit,AdminStates>(

      listener: (context,state){},
      builder: (context,state){

        return Scaffold(

          body:Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.5, 5],
                    colors: [Colors.white, Colors.redAccent])




            ),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logotogo3.png",
                        height:  300,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(),
                        child: RoundedInputField(
                          keyboard: TextInputType.emailAddress,
                          cont: Category,
                          valid: (value){
                            if (value!.isEmpty)
                              return 'Category must not be empty';
                            else
                              return null;


                          },

                          icon: Icon(

                            Icons.category,
                            color: Colors.pink,
                          ),
                          vis: false,

                          hintText: "Add category",
                          onChanged: (value) {},


                        ),
                      ),
                      SizedBox(height: size.height * 0.06),

                      ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          primary:Colors.pink,
                          padding: EdgeInsets.fromLTRB(85, 15, 85, 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // <-- Radius
                          ),
                        ),

                        onPressed: () {


                          if (formkey.currentState!.validate()) {

                            AdminCubit.get(context).CreateCategory(Category.text);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ControlScreen()));


                          }




                        },
                        child: Text("ADD"), ) ,





                    ],
                  ),
                ),
              ),
            ),
          ),

        );
      },

    );

  }



}