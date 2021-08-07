import 'package:elha2ny/Screens/AdminScreen/AdminCubit/AdminCubit.dart';
import 'package:elha2ny/Screens/AdminScreen/AdminCubit/AdminState.dart';
import 'package:elha2ny/Screens/AdminScreen/AdminScreen.dart';
import 'package:elha2ny/Screens/AdminScreen/ControlScreen.dart';
import 'package:elha2ny/Screens/Login/Cubit/LoginCubit.dart';
import 'package:elha2ny/Screens/Login/Cubit/LoginState.dart';
import 'package:elha2ny/components/rounded_input_field.dart';
import 'package:elha2ny/components/rounded_password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginAdmin extends StatelessWidget
{
  var formkey= GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AdminCubit,AdminStates>(
        listener: (context,states){

          if(states is AdminloginSuccessState )
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ControlScreen()));

          }
          if(states is  AdminloginErrorState )
          {
            Fluttertoast.showToast(
              msg: "Wrong email or password, Try again",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,

            );
          }



        },
        builder: (context,states){
          return Scaffold(

            // resizeToAvoidBottomInset: false,

            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.5, 5],
                      colors: [Colors.white, Colors.redAccent])),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 100, 0, 110),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        SizedBox(height: size.height * 0.03),
                        Hero(
                          tag:'logo',
                          child: Image.asset(
                            "assets/images/logotogo3.png",
                            height: size.height * 0.4,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Center(
                          child: RoundedInputField(
                            keyboard: TextInputType.emailAddress,
                            cont: email,
                            valid: (value){
                              if (value!.isEmpty)
                                return 'email must not be empty';
                              else
                                return null;


                            },

                            icon: Icon(

                              Icons.email,
                              color: Colors.pink,
                            ),
                            vis: false,

                            hintText: "Your Email",
                            onChanged: (value) {},


                          ),
                        ),
                        Center(
                          child: RoundedPasswordField(

                            suff: AdminCubit.get(context).suffix,
                            onPressSuffix : (){

                              AdminCubit.get(context).changeVisiblityPassward();
                            },
                            keyboard: TextInputType.visiblePassword,
                            cont: password,
                            valid: (value){
                              if (value!.isEmpty)
                                return 'password must not be empty';
                              else
                                return null;


                            },

                            icon: Icon(

                              Icons.lock_outline,
                              color: Colors.pink,
                            ),
                            vis: AdminCubit.get(context).isPassword,

                            hintText: "Your Password",



                          ),
                        ),


                        SizedBox(height: size.height * 0.06),

                        Center(
                          child: ElevatedButton(

                            style: ElevatedButton.styleFrom(
                              primary:Colors.pink,
                              padding: EdgeInsets.fromLTRB(85, 15, 85, 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20), // <-- Radius
                              ),
                            ),

                            onPressed: () async {


                              if (formkey.currentState!.validate()) {

                                await AdminCubit.get(context).Adminlogin(email.text, password.text) ;
                                await AdminCubit.get(context).getAllunthenUser();

                              }




                            },
                            child: Text("LOGIN"), ),
                        ) ,


                      ],
                    ),
                  ),
                ),
              ),
            ),


          );




        }
    );


  }



}