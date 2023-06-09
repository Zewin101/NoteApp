import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/component/defaultTextForm.dart';
import 'package:noteapp/shared/remot/api.dart';
import '../../generated/assets.dart';
import 'singinScreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const String routeName = 'signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
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
                    hintText: 'email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email),
                    controller: emailController,
                    validator: (value) {
                      if (value == '' || value!.isEmpty) {
                        return 'email is empty';
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return "Wrong email writing";
                      }

                      return null;
                    }),
                const SizedBox(
                  height: 5,
                ),
                DefaultTextForm(
                  maxLines: 1,
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
                    onPressed: () async {
                      await logUpUser();
                    },
                    child: const Text(
                      'create account',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    )),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                    onPressed: () {
                      goToSingIn();
                    },
                    child: const Text(
                      "I have account...",
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

  logUpUser() async {
    if (formKey.currentState!.validate()) {
      Map user = {
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text
      };
      var response = await ApiShare.addUserToDatabase(user);
      setState(() {});

      AwesomeDialog(
          context: context,
          btnOkOnPress: () {
            Navigator.pushReplacementNamed(context, SingIn.routeName);
          },
          body: const Text(
            'تسجيل ناجح',
            style: TextStyle(
              fontSize: 17,
            ),
          )).show();
    }
  }

  void goToSingIn() {
    Navigator.pushNamed(context, SingIn.routeName);
  }
}
