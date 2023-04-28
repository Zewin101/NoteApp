import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:noteapp/constant/constant.dart';

import '../../models/ViewNotes.dart';
import '../../models/usersAuth.dart';

class ApiShare {
  static getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print('error ${response.statusCode}');
      }
    } catch (e) {
      print("error catch $e");
    }
  }

  static postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print('error  ${response.statusCode}');
      }
    } catch (e) {
      print("error catch  *  $e");
    }
  }

  static Future<ViewNotes> getData(String id) async {
    Response response =
    await http.post(Uri.parse(linkViewNotes), body: {'id': id});
    var json = jsonDecode(response.body);
    ViewNotes viewNotes = ViewNotes.fromJson(json);
    return viewNotes;
  }


  static Future addUserToDatabase(Map users)async{
    Response response=await http.post(Uri.parse(linkSingUp),body:users );
    return response;
  }


  static Future<http.Response> addData(String id, String title,
      String content) async {
    Response response = await http.post(Uri.parse(linkAddNote),
        body: {'id': id, 'title': title, 'content': content});

    return response;
  }

  static Future<http.Response> deleteData(String idNote) async {
    var response =
    await http.post(Uri.parse(linkDeleteNote), body: {'id': idNote});
    return response;
  }

  static Future<http.Response> editNote(String idNote, String title,
      String content) async {
    Response response = await http.post(Uri.parse(linkEditNote),
        body: {'id': idNote, 'title': title, 'content': content});
    return response;
  }

}
