import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp/component/defaultTextForm.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/main.dart';
import 'package:noteapp/shared/remot/api.dart';

import '../../component/show_dialog.dart';
import '../home_screen.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);
  static const String routeName = 'addNotes';

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? myFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),

      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              DefaultTextForm(
                hintText: 'title',
                controller: titleController,
                validator: (value) {
                  if (value?.trim() == '' || value!.isEmpty) {
                    return 'title is empty';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              DefaultTextForm(
                maxLines: 15,
                hintText: 'content',
                controller: contentController,
                validator: (value) {
                  if (value?.trim() == '' || value!.isEmpty) {
                    return 'content is empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.18,
                        child: Column(
                          children: [
                            const Text(
                              'Choose Image ',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                XFile? xFile = await ImagePicker()
                                    .pickImage(source: ImageSource.camera);
                                Navigator.pop(context);
                                myFile = File(xFile!.path);
                                print(myFile!.path);
                                setState(() {
                                });
                              },
                              child: const SizedBox(
                                width: double.infinity,
                                height: 30,
                                child: Text(
                                  'From Camera',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                XFile? xFile = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                Navigator.of(context).pop();
                                myFile = File(xFile!.path);
                                setState(() {

                                });
                                print(myFile!.path);

                              },
                              child: Container(
                                width: double.infinity,
                                height: 30,
                                child: const Text(
                                  'From Gallery',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );

                  },
                  child: const Text('upload  image')),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await addNoteInDatabase();
                  },
                  child: const Text('Add Note'))
            ],
          ),
        ),
      ),
    );
  }

  addNoteInDatabase() {
    try {
      if (formKey.currentState!.validate()) {
        Show_Dialog.showLoading(context);
        ApiShare.uploadImages(myFile!, sharedPreferences.getString('id')!,
            titleController.text, contentController.text);
        print(myFile!.path);
        Show_Dialog.hideLoading(context);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        Show_Dialog.showMessage("تم الاضافة  بنجاح", context);
        print('تم الاضافة  بنجاح');
      }
    } catch (e) {
      print('Error -> $e');
      print('حدث خطاء ما ');
    }
  }
}
