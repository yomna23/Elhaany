import 'package:conditional_builder/conditional_builder.dart';
import 'package:elha2ny/Screens/HomePage/Home_Page.dart';
import 'package:elha2ny/Screens/Login/components/background.dart';
import 'package:elha2ny/Screens/RegisterAuthScreen/RegisterAuth.dart';
import 'package:elha2ny/Screens/Signup/Cubit/SignUpCubit.dart';
import 'package:elha2ny/Screens/Signup/Cubit/SignUpState.dart';
import 'package:elha2ny/Screens/Welcome/welcome_screen.dart';
import 'package:elha2ny/components/WholeAppCubit/AppCubit.dart';
import 'package:flutter/material.dart';
import 'package:elha2ny/components/rounded_input_field.dart';
import 'package:elha2ny/components/rounded_password_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var password = TextEditingController();
    var repassword = TextEditingController();
    var NationalId = TextEditingController();
    var phone = TextEditingController();
    var name = TextEditingController();
    var formkey= GlobalKey<FormState>();


    Size size = MediaQuery.of(context).size;
   return BlocConsumer<RegisterCubit,RegisterStates>(
    // int Gcode = RegisterCubit.get(context).generateRandom()
          listener: (context,State){

            if(State is CreateUserSucccesState)
            {
              Navigator.push(context , MaterialPageRoute(builder: (context) => WelcomeScreen()) );
            }
            if(State is CreateUserSucccesState)
              {
                Fluttertoast.showToast(
                  msg: "You are registed, Wait for authentication in few hours",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,

                );


              }
            if(State is RegisterErrorState) {

                Fluttertoast.showToast(
                  msg: "Something went wrong",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,

                );
              }

            }
          ,

          builder: (context,State){
            return Background(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          "assets/images/logotogo3.png",
                          height: size.height * 0.2,
                        ),
                      ),
                      RoundedInputField(

                        keyboard: TextInputType.name,
                        cont: name,
                        valid: (value) {
                          if (value!.isEmpty)
                            return 'Name must not be empty';
                          else
                            return null;
                        },
                        vis: false,
                        icon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        hintText: "Name",
                        onChanged: (value) {},
                      ),
                      RoundedInputField(
                        keyboard: TextInputType.number,
                        cont: NationalId,
                        valid: (value) {
                          if (value!.isEmpty)
                            return 'National ID must not be empty';
                          else if (value.length < 14 || value.length > 14)
                            return 'National ID is invalid';
                          else
                            return null;
                        },
                        vis: false,
                        icon: Icon(
                          Icons.credit_card_rounded,
                          color: kPrimaryColor,
                        ),
                        hintText: "National ID",
                        onChanged: (value) {},
                      ),
                      RoundedInputField(


                        keyboard: TextInputType.emailAddress,
                        cont: email,
                        valid: (value) {
                          if (value!.isEmpty)
                            return 'email must be not empty';
                          else
                            return null;
                        },
                        vis: false,
                        icon: Icon(
                          Icons.email_outlined,
                          color: kPrimaryColor,
                        ),
                        hintText: "Email",
                        onChanged: (value) {},
                      ),
                      RoundedPasswordField(


                          keyboard: TextInputType.visiblePassword,
                          cont: password,
                          valid: (value) {

                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                            if(value.length < 8 )
                            {
                              return 'Password must be not less than 8 characters';
                            }
                            else if(value.length > 20)
                              return 'Password must not be more than 20 characters';
                            else
                            {
                              bool hasUppercase = password.text.contains(new RegExp(r'[A-Z]'));
                              bool hasDigits = password.text.contains(new RegExp(r'[0-9]'));
                              bool hasLowercase = password.text.contains(new RegExp(r'[a-z]'));
                              bool hasSpecialCharacters = password.text.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                              if(hasUppercase == false)
                                return 'Password must contain uppercase';
                              if(hasDigits == false)
                                return 'Password must contain digits';
                              if(hasLowercase == false)
                                return 'password must contain lowercase ';
                              if(hasSpecialCharacters == false)
                                return 'password must contain specialCharacter';

                            }
                          },


                          vis: RegisterCubit.get(context).isPassword,

                          icon: Icon(
                            Icons.lock_outlined,
                            color: kPrimaryColor,
                          ),
                          hintText: "Password",

                          suff: RegisterCubit.get(context).suffix,
                          onPressSuffix: (){

                            RegisterCubit.get(context).changePasswordVisiblity();

                          }
                      ),
                      RoundedPasswordField(

                        suff: RegisterCubit.get(context).suffix,


                        onPressSuffix: (){
                          RegisterCubit.get(context).changePasswordVisiblity();
                        },


                        keyboard: TextInputType.visiblePassword,
                        cont: repassword,
                        valid: (value){
                          if (value!.isEmpty)
                          {return 'Password must be not empty';}
                          else if(password.text != repassword.text)
                          {return 'Password not matching !';}
                          else
                            return null;



                        },
                        vis: RegisterCubit.get(context).isPassword,
                        icon: Icon(
                          Icons.lock_outline,
                          color: kPrimaryColor,
                        ),
                        hintText: "Re-enter your Password",

                      ),
                      RoundedInputField(

                        keyboard: TextInputType.number,
                        cont: phone,
                        valid: (value){
                          if (value!.isEmpty)
                            return 'Phone must be not empty';
                          else if(value.length <11  || value.length > 11)
                            return 'Phone number is invalid';
                          else
                            return null;
                        },
                        vis: false,
                        icon: Icon(
                          Icons.phone,
                          color: kPrimaryColor,
                        ),
                        hintText: "Phone number",
                        onChanged: (value) {},
                      ),
                      SizedBox(height: size.height * 0.03),

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink,
                            padding: EdgeInsets.fromLTRB(85, 15, 85, 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // <-- Radius
                            ),
                          ),
                          onPressed: () async {

                            if (formkey.currentState!.validate()){
                           // await RegisterCubit.get(context).Register(name.text, email.text, password.text, phone.text, NationalId.text);
                                double latitude = ElhaanyCubit.get(context).position.latitude ;
                                double longitude = ElhaanyCubit.get(context).position.longitude;


                                print('its latitude and longitude from registeeeeeeeeeeeeeeeeeeeer');
                                print('its latitude $latitude');
                                print('its longitude $longitude');
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  RegisterAuth(name.text,email.text,password.text,NationalId.text,phone.text,latitude,longitude) ));

                            }
                          },
                          child: Text("Continue"),
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