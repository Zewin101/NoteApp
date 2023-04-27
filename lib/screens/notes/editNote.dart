import 'package:flutter/material.dart';
import 'package:noteapp/models/ViewNotes.dart';
import 'package:noteapp/shared/remot/api.dart';
import '../../component/defaultTextForm.dart';
import '../../component/show_dialog.dart';
import '../home_screen.dart';

class EditNote extends StatefulWidget {
  EditNote({Key? key}) : super(key: key);
  static const String routeName = 'editNotes';

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)?.settings.arguments as Data;
    titleController.text = arg.notesTitle ?? '';
    contentController.text = arg.notesContent ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note '),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
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
            const SizedBox(
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
                  await editNoteInDatabase(context);
                },
                child: const Text('Add Note'))
          ],
        ),
      ),
    );
  }

  editNoteInDatabase(BuildContext context) async {
    var arg = ModalRoute.of(context)?.settings.arguments as Data;
    try{
      if (formKey.currentState!.validate()) {
        Show_Dialog.showLoading(context);
      ApiShare.editNote(
            arg.notesId!.toString(), titleController.text, contentController.text);
        Show_Dialog.hideLoading(context);
       Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        Show_Dialog.showMessage("تم التعديل  بنجاح", context);
      }
    }catch(e){
      print('Error -> $e');
      print(arg.notesId);
    }

  }
}
