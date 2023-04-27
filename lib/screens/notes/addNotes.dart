import 'package:flutter/material.dart';
import 'package:noteapp/component/defaultTextForm.dart';
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
    try{
      if (formKey.currentState!.validate()) {
        Show_Dialog.showLoading(context);
        var response = ApiShare.addData(
            sharedPreferences.getString('id').toString(),
            titleController.text,
            contentController.text);
        Show_Dialog.hideLoading(context);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        Show_Dialog.showMessage("تم الاضافة  بنجاح", context);
      }
    }catch(e){
      print('Error -> $e');
    }
  }
}
