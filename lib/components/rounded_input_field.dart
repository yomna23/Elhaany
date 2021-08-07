import 'package:flutter/material.dart';
import 'package:elha2ny/components/text_field_container.dart';
import 'package:elha2ny/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final Widget icon;
   final bool vis;
   final TextEditingController cont;
   final FormFieldValidator<String> valid;
   final ValueChanged<String> onChanged;
   final TextInputType keyboard;

   RoundedInputField({
    Key? key,
    required this.keyboard,
    required this.valid,
    required this.cont,
    required this.hintText,
    required this.icon,
    required this.vis,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFieldContainer(
      child: TextFormField(




        keyboardType: keyboard,
        controller: cont,
        obscureText: vis,
        validator: valid,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,

        decoration: InputDecoration(

          icon: icon,
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
