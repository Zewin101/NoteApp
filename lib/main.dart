import 'package:flutter/material.dart';
import 'package:noteapp/screens/auth/SignUpScreen.dart';
import 'package:noteapp/screens/auth/logninScreen.dart';
import 'package:noteapp/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SingIn.routeName,
      routes: {
        SingIn.routeName: (context) => const SingIn(),
        SignUp.routeName: (context) => const SignUp(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
