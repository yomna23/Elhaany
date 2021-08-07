import 'package:flutter/material.dart';
import 'package:elha2ny/components/text_field_container.dart';
import 'package:elha2ny/constants.dart';

class RoundedDescriptionField extends StatelessWidget {
  final String hintText;

  final TextEditingController cont;
  final ValueChanged<String> onChanged;
  final TextInputType keyboard;


  RoundedDescriptionField({
    Key? key,

    required this.cont,
    required this.hintText,


    required this.onChanged,
    required this.keyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFieldContainer(
      child: TextFormField(




        controller: cont,

        onChanged: onChanged,
        cursorColor: kPrimaryColor,

        decoration: InputDecoration(

          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black26,),

          border: InputBorder.none,
        ),
      ),
    );
  }
}
