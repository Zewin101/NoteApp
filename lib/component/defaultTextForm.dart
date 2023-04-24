import 'package:flutter/material.dart';

class DefaultTextForm extends StatelessWidget {
String hintText;
Widget prefixIcon;
Widget suffixIcon;


DefaultTextForm(this.hintText, this.prefixIcon, this.suffixIcon);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText:hintText ,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.blueAccent,
          )
        )
      ),
    );
  }
}
