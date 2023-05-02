import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/component/defaultTextForm.dart';
import 'package:noteapp/generated/assets.dart';
import 'package:noteapp/main.dart';
import 'package:noteapp/screens/auth/signUpScreen.dart';
import 'package:noteapp/screens/home_screen.dart';
import 'package:noteapp/screens/test.dart';
import 'package:noteapp/shared/remot/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../component/show_dialog.dart';
import '../../constant/constant.dart';

class SingIn extends StatefulWidget {
  const SingIn({Key? key}) : super(key: key);
  static const String routeName = 'login';

  @override
  State<SingIn> createState() => _LoginState();
}

class _LoginState extends State<SingIn> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(Assets.imageLogo,
                              height: MediaQuery.of(context).size.height * .20,
                              width: MediaQuery.of(context).size.width * .50),
                          const SizedBox(
                            height: 5,
                          ),
                          DefaultTextForm(
                              maxLines: 1,
                              hintText: 'username',
                              prefixIcon: const Icon(Icons.people),
                              controller: usernameController,
                              validator: (value) {
                                if (value == '' || value!.isEmpty) {
                                  return 'username is empty';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 5,
                          ),
                          DefaultTextForm(
                            hintText: 'password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: isPassword
                                ? const Icon(Icons.remove_red_eye)
                                : const Icon(Icons.remove_red_eye_outlined),
                            controller: passwordController,
                            validator: (value) {
                              if (value == '' || value!.isEmpty) {
                                return 'password is empty';
                              }
                              return null;
                            },
                            isPassword: () {
                              isPassword = !isPassword;
                              setState(() {});
                            },
                            obscureText: isPassword,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await loginUser();
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          TextButton(
                              onPressed: () {
                                goToSingUp();
                              },
                              child: const Text(
                                "I don't have account...",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  loginUser() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await ApiShare.postRequest(linkSingIn, {
        'username': usernameController.text,
        'password': passwordController.text
      });
      setState(() {});
      if (response['status'] == "success") {
        print(response);
        sharedPreferences.setString("id", response['data']['id'].toString());
        sharedPreferences.setString(
            "username", response['data']['username'].toString());
        sharedPreferences.setString(
            "email", response['data']['email'].toString());
        sharedPreferences.setString(
            "password", response['data']['password'].toString());
        AwesomeDialog(
            context: context,
            btnOkOnPress: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
            body: const Text(
              'تسجيل دخول ناجح',
              style: TextStyle(
                fontSize: 17,
              ),
            )).show();
      } else {
        AwesomeDialog(
            context: context,
            btnOkOnPress: () {
              Navigator.pushReplacementNamed(context, SingIn.routeName);
            },
            title: "تنبيه",
            body: const Text(
              'اسم المستخدم او كلمة المرور غير صحيح',
              style: TextStyle(
                fontSize: 17,
              ),
            )).show();
      }
    }
  }

  void goToSingUp() {
    Navigator.pushNamed(context, SignUp.routeName);
  }
}
