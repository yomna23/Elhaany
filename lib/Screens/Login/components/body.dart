
import 'package:conditional_builder/conditional_builder.dart';
import 'package:elha2ny/Network/Local/Cache.dart';
import 'package:elha2ny/Screens/HomePage/Components/body.dart';
import 'package:elha2ny/Screens/Login/Cubit/LoginCubit.dart';
import 'package:elha2ny/Screens/Login/Cubit/LoginState.dart';
import 'package:elha2ny/Screens/LoginAdmin/loginadmin.dart';
import 'package:elha2ny/Screens/ResetPasswordScreen/ResetPasswordScreen.dart';
import 'package:elha2ny/Screens/Welcome/welcome_screen.dart';
import 'package:elha2ny/components/WholeAppCubit/AppCubit.dart';
import 'package:elha2ny/components/rounded_input_field.dart';
import 'package:elha2ny/components/rounded_password_field.dart';
import 'package:elha2ny/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';
import '../../../constants.dart';
import 'background.dart';


class Body extends StatelessWidget {

  var email = TextEditingController();
  var password = TextEditingController();
  var formkey= GlobalKey<FormState>();
  Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


        return BlocConsumer<loginCubit,states>(

          listener: (context,State){



            if(State is loginSuccessState)
            {
              if(loginCubit.get(context).user.isAuthenticated == true)
              {
                print('hellllllllllllloooooooooooooooooooooooooooooooooooo Userr !!!!!!!!!!!!!!1') ;

                print(State.uId) ;
                CacheHelper.saveData(key: 'uId', value: State.uId).then((value) {
                  uId = State.uId.toString() ;
                  print(uId) ;
                  ElhaanyCubit.get(context).getUserData() ;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage())) ;

                });

              }
              else
              {


                Fluttertoast.showToast(
                  msg: "you are not authenticated yet",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,

                );

                Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen())) ;





              }
                /*print('heeeeeeeeeeeeeeey') ;
                print(State.uId) ;
                CacheHelper.saveData(key: 'uId', value: State.uId).then((value) {
                uId = State.uId.toString() ;
                print(uId) ;
                ElhaanyCubit.get(context).getUserData() ;
                Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage())) ;
            });*/
            }
            if(State is loginErrorState)
              {
                Fluttertoast.showToast(
                    msg: "Wrong email or password",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,

                );

              }








          },
          builder: (context,State){

            return Background(

              key:null,
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
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
                      RoundedInputField(
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
                      RoundedPasswordField(

                        suff: loginCubit.get(context).suffix,
                        onPressSuffix : (){

                          loginCubit.get(context).changeVisiblityPassward();
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
                        vis: loginCubit.get(context).isPassword,

                        hintText: "Your Password",



                      ),


                      SizedBox(height: size.height * 0.06),

                      ElevatedButton(


                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink,
                          padding: EdgeInsets.fromLTRB(85, 15, 85, 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // <-- Radius
                          ),
                        ),

                        onPressed: ()  {


                            if (formkey.currentState!.validate()) {

                              loginCubit.get(context).login(
                                    email.text ,password.text);
                              





                          }




                        },
                        child: Text("LOGIN"), ) ,
                      Center(
                        child: TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => resetPassword()));
                            },
                            child:Text('Forget your password ?', style: TextStyle(fontSize: 16.0),) ),
                      ),

                      Center(
                        child: TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginAdmin()));
                            },
                            child:Text('Login as admin', style: TextStyle(fontSize: 16.0),) ),
                      ),









                    ],
                  ),
                ),
              ),
            );

          },



        );




  }
}