
import 'package:elha2ny/components/WholeAppCubit/AppCubit.dart';
import 'package:elha2ny/components/WholeAppCubit/AppStates.dart';
import 'package:elha2ny/components/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';

class resetPassword extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    var email = TextEditingController();
    var formkey = GlobalKey<FormState>();

    return BlocConsumer<ElhaanyCubit, ELhaanyStates>(

        listener: (context, State) {

        },
        builder: (context, State) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
              body:Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [


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
                  ElevatedButton(


                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      padding: EdgeInsets.fromLTRB(85, 15, 85, 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // <-- Radius
                      ),
                    ),

                    onPressed: () async {

                        await ElhaanyCubit.get(context).ResetPassword(email: email.text);
                        Navigator.of(context).pop();




                    },
                    child: Text("Send Request"), ) ,
                ],
              )
          );
        }

    );
  }

}