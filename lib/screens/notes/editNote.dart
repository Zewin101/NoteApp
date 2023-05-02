import 'package:flutter/material.dart';
import 'package:noteapp/models/ViewNotes.dart';
import 'package:noteapp/shared/remot/api.dart';
import '../../component/defaultTextForm.dart';
import '../../component/show_dialog.dart';
import '../../main.dart';
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
  Data? arg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    arg = Data(notesTitle: titleController.text,notesContent: contentController.text);
  }

  @override
  Widget build(BuildContext context) {
    arg = ModalRoute.of(context)?.settings.arguments as Data;
    titleController.text = arg!.notesTitle!;
    contentController.text = arg!.notesContent!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note '),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              DefaultTextForm(
                hintText: 'title',
                controller: titleController,
                validator: (value) {
                  if (value?.trim() == '') {
                    return 'content is empty';
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
                  if (value?.trim() == '') {
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
                    await editNoteInDatabase();
                  },
                  child: const Text('Add Note'))
            ],
          ),
        ),
      ),
    );
  }

  editNoteInDatabase() async {
    if (formKey.currentState!.validate()) {
    try{
      Show_Dialog.showLoading(context);
      var response= ApiShare.editNote(arg!.notesId.toString(), titleController.text,
          contentController.text,arg!.notesImage.toString());
      Show_Dialog.hideLoading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      Show_Dialog.showMessage("تم التعديل  بنجاح", context);
    }catch (e){
      Show_Dialog.showMessage("حدث خطاء!!", context);
    }
      ///
      print(arg!.notesId);
      print(arg!.notesTitle);
      print(arg!.notesContent);
    }
  }
}
