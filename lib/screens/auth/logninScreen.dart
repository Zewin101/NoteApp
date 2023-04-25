import 'package:flutter/material.dart';
import 'package:noteapp/component/defaultTextForm.dart';
import 'package:noteapp/generated/assets.dart';
import 'package:noteapp/screens/auth/SignUpScreen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const String routeName = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
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
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      loginUser();
                    },
                    child: const Text(
                      'login',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
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
    );
  }

  void loginUser() {
    if (formKey.currentState!.validate()) {}
  }

  void goToSingUp() {
    Navigator.pushNamed(context, SignUp.routeName);
  }
}
