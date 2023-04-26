import 'package:flutter/material.dart';
const Color RODINACOLOR = Color.fromRGBO(60, 51, 115, 1.0);
class Show_Dialog{
 static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  static void showLoading(BuildContext context,{String message = "Loading..."}) {
    showDialog(

      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: RODINACOLOR,
          title: Center(child: Container(
            color:  RODINACOLOR,
            child: Row(
              children: [
                Text(message,style: const TextStyle(
                  color: Colors.white,
                ),),
                const SizedBox(
                  width: 15,
                ),

                const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),
          )),
        );
      },
    );
  }

  @override
  static void showMessage(String message,BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: RODINACOLOR,
          content: Text(message),
        );
      },
    );
  }
}