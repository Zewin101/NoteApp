import 'package:flutter/material.dart';
import 'package:noteapp/component/defaultTextForm.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
static const String routeName='signup';
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
