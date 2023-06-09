import 'package:flutter/material.dart';
import 'package:noteapp/screens/auth/signUpScreen.dart';
import 'package:noteapp/screens/auth/singinScreen.dart';
import 'package:noteapp/screens/home_screen.dart';
import 'package:noteapp/screens/notes/addNotes.dart';
import 'package:noteapp/screens/notes/editNote.dart';
import 'package:noteapp/screens/test.dart';
import 'package:shared_preferences/shared_preferences.dart';


late SharedPreferences sharedPreferences;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:sharedPreferences.getString('id')==null? SingIn.routeName:HomeScreen.routeName,

      routes: {
        SingIn.routeName: (context) => const SingIn(),
        SignUp.routeName: (context) => const SignUp(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        AddNotes.routeName: (context) => const AddNotes(),
        EditNote.routeName: (context) =>  EditNote(),
        testddd.routeName: (context) =>   testddd(),
      },
    );
  }
}
