import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elha2ny/components/text_field_container.dart';
import 'package:elha2ny/constants.dart';

class RoundedProfileField extends StatelessWidget {
  final String hintText;
 // final Widget icon;
  //final bool vis;
  final TextEditingController cont;
  final FormFieldValidator<String> valid;
 // final ValueChanged<String> onChanged;
  final TextInputType keyboard;
  final IconData suff;
  final VoidCallback  onPressSuffix;

  RoundedProfileField({
    Key? key,

    required this.suff,
    required this.keyboard,
    required this.valid,
    required this.cont,
    required this.hintText,
   // required this.icon,
    //required this.vis,
    //required this.onChanged,
    required this.onPressSuffix
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFieldContainer(



      child: TextFormField(






        keyboardType: keyboard,
        controller: cont,
       // obscureText: vis,
         validator: valid,
        //onChanged: onChanged,
        cursorColor: Colors.black,

        decoration: InputDecoration(


          suffixIcon: IconButton(
            onPressed : onPressSuffix ,
            icon: Icon(suff),
          ),

          //icon: icon,
          hintText: hintText,
          hintStyle: TextStyle(
            color:Colors.grey,
            fontSize: 17,
            fontWeight: FontWeight.bold,

          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}