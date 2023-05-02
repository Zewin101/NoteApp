import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:path/path.dart';
import '../../models/ViewNotes.dart';

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

  static Future addUserToDatabase(Map users) async {
    Response response = await http.post(Uri.parse(linkSingUp), body: users);
    return response;
  }

  static Future<http.Response> addData(String id, String title, String content,
      String notesImage) async {
    Response response = await http.post(Uri.parse(linkAddNote), body: {
      'id': id,
      'title': title,
      'content': content,
      'image': notesImage
    });

    return response;
  }

  static Future<http.Response> deleteData(String idNote,String imageName) async {
    var response =
    await http.post(Uri.parse(linkDeleteNote), body: {'id': idNote,'imagename':imageName});
    return response;
  }

  static Future<http.Response> editNote(String idNote, String title,
      String content,String image) async {
    Response response = await http.post(Uri.parse(linkEditNote),
        body: {'id': idNote, 'title': title, 'content': content,'imagename':image});
    return response;
  }

  static uploadImages(File file, String id, String title,
      String content) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(linkAddNote));
      var length = await file.length();
      var stream = http.ByteStream(file.openRead());
      var multiPartFile = http.MultipartFile('image', stream, length,
          filename: basename(file.path));
      request.files.add(multiPartFile);
      request.fields['title'] = title;
      request.fields['content'] = content;
      request.fields['id'] = id;
      print(basename(file.path));
      var myResponse = await request.send();
      var response = await http.Response.fromStream(myResponse);
      if (response.statusCode == 200) {
        print('File Uploaded ');
        return jsonDecode(response.body);
      } else {
        print('Upload Failed!');
      }
    } catch (e) {
      print('error $e');
    }
  }
}
