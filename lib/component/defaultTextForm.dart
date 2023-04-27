import 'package:flutter/material.dart';

class DefaultTextForm extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function? isPassword;
  final bool? obscureText ;
  final int? maxLines ;

  DefaultTextForm(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.validator,
      this.prefixIcon,
      this.suffixIcon,
      this.keyboardType,
      this.isPassword,
      this.obscureText,
        this.maxLines
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      obscureText: obscureText??false,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: IconButton(
            onPressed: () {
              isPassword!();
            },
            icon: suffixIcon ?? Text('')),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.blueAccent,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
