import 'package:elha2ny/Screens/HomePage/Home_Page.dart';
import 'package:elha2ny/Screens/Profile/Profile_Page.dart';
import 'package:elha2ny/components/text_field_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elha2ny/Screens/Login/login_screen.dart';
import 'package:elha2ny/Screens/Signup/signup_screen.dart';
import 'package:elha2ny/Screens/Welcome/components/background.dart';
import 'package:elha2ny/components/rounded_button.dart';
import 'package:elha2ny/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.05),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,

            children: [


              Expanded(

                flex: 1,
                child: Hero(
                  tag:'logo',
                  child: Container(
                    child: Image.asset(
                      "assets/images/logotogo3.png",
                      height: size.height * 0.4,
                    ),
                  ),
                ),
              ),

              
              Expanded(
                flex: 1,
                child: Container(
                  child: Image.asset(
                    "assets/images/logotogo1.png",
                    height: size.height * 0.4,
                  ),

                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          ElevatedButton(

            style: ElevatedButton.styleFrom(
              primary: Colors.pink,

              padding: EdgeInsets.fromLTRB(85, 15, 85, 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // <-- Radius
              ),
            ),
          
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //return LoginScreen();
                  return LoginScreen();
                }));
              },
              child: Text("LOGIN")),

          SizedBox(height: 10,),

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,

                padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // <-- Radius
                ),
              ),



              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignUpScreen();
                }));
              },
              child: Text("SIGN UP"))
        ],
      ),
    ));
  }
}
