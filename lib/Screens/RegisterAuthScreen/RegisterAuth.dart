import 'package:elha2ny/Screens/Signup/Cubit/SignUpCubit.dart';
import 'package:elha2ny/Screens/Welcome/welcome_screen.dart';
import 'package:elha2ny/components/WholeAppCubit/AppCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elha2ny/Screens/Signup/Cubit/SignUpState.dart';

class RegisterAuth extends StatelessWidget
{

  final String name ;
  final String email ;
  final String password;
  final String NationalId ;
  final String phone ;
  final double latitude;
  final double longitude ;


  RegisterAuth(this.name, this.email, this.password, this.NationalId, this.phone,this.latitude,this.longitude) ;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterStates>(
      listener: (context,state){},
      builder: (context,state){
        int code = RegisterCubit.get(context).randomValue ;
        String? Token= RegisterCubit.get(context).tokenId ;
        var AuthenticateUserimage = RegisterCubit.get(context).AuthenticateUserimage ;

        return Scaffold(
          backgroundColor: Colors.white,

          body:
          Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:Colors.pink,
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // <-- Radius
                            ),
                          ),
                          onPressed: () {
                            RegisterCubit.get(context).generateRandom() ;

                            //if (formkey.currentState!.validate()) {


                            // Navigator.push(context, MaterialPageRoute(builder: (context) =>  WelcomeScreen() ));

                          },
                          child: Text("Generate code"),
                        )],
                    ),
                  ),
                  if(state is GenerateNumberState)
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${code}'),
                        ],
                      ),
                    ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Please upload a clear photo of you with the generated random number and national ID',style: TextStyle(letterSpacing: 1.5,
                    fontWeight: FontWeight.w600),),
              ),

              /*  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Click here' , style: TextStyle(fontSize: 16.0,color:Colors.pink)),

                  IconButton(onPressed:() async {
                    await RegisterCubit.get(context).getImageee() ;
                  }, icon:Icon(Icons.camera_alt_outlined),color: Colors.pink,),
                ],
              ),*/

              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                          child:
                          CircleAvatar(
                              backgroundImage:FileImage(AuthenticateUserimage)
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
                            await RegisterCubit.get(context).getImageee() ;
                          },
                          icon: Icon(Icons.camera_alt_rounded),

                          color: Colors.white,
                        ),
                      )),
                ],
              ),

              SizedBox(
                height: 70.0,
              )
              ,
              Container(

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:Colors.pink,
                      padding: EdgeInsets.fromLTRB(70, 15, 70, 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      RegisterCubit.get(context).uploadAuthenticationImage();

                      //if (formkey.currentState!.validate()) {


                      // Navigator.push(context, MaterialPageRoute(builder: (context) =>  WelcomeScreen() ));

                    },
                    child: Text("Upload Photo"),
                  )
              ),

              //ConditionalBuilder(
              // condition: State is! RegisterLoadingState,
              // builder: (context) =>

              SizedBox(
                height: 20.0,
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

                  //if (formkey.currentState!.validate()) {

                  await RegisterCubit.get(context).Register(name, email, password, phone, NationalId,latitude,longitude,code,Token!);

                  // Navigator.push(context, MaterialPageRoute(builder: (context) =>  WelcomeScreen() ));

                },
                child: Text("SIGN UP"),
              ),







            ],





          ),



        );

      },







    );

  }

}