import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/component/card.dart';
import 'package:noteapp/models/ViewNotes.dart';
import 'package:noteapp/screens/auth/singinScreen.dart';
import 'package:noteapp/screens/notes/addNotes.dart';
import 'package:noteapp/screens/notes/editNote.dart';
import '../component/show_dialog.dart';
import '../constant/constant.dart';
import '../main.dart';
import '../shared/remot/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ApiShare {
  String? userId = sharedPreferences.getString('id');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            setState(() {

            });
          }, icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                singOut();
              },
              icon: const Icon(Icons.exit_to_app)),



        ],
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNotes.routeName);
          print(sharedPreferences.getString('id'));
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder<ViewNotes>(
          future: ApiShare.getData(sharedPreferences.getString('id')!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data?.status == 'filed') {
              return const Center(
                  child: Text(
                'لا يوجد ملاحظات',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ));
            }
            if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }
            var allData = snapshot.data?.data ?? [];
            return ListView.builder(
              itemCount: allData.length,
              itemBuilder: (context, index) {
                return CardNotes(
                  title: '${allData[index].notesTitle}',
                  content: '${allData[index].notesContent}',
                  image:'${allData[index].notesImage}' ,
                  onTap: () {
                    Navigator.pushNamed(context, EditNote.routeName,
                        arguments: Data.inti(
                            allData[index].notesId,
                            allData[index].notesTitle,
                            allData[index].notesContent,
                            allData[index].notesImage
                        ));
                    print(allData[index].notesId);
                    print('${allData[index].notesImage}');
                  },
                  /// Delete Note
                  delete: () async {
                    await ApiShare.deleteData('${allData[index].notesId}',allData[index].notesImage.toString());
                    setState(() {});
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void singOut() {
    /// Sing Out
    AwesomeDialog(
        context: context,
        btnOkOnPress: () {
          sharedPreferences.clear();
          Navigator.pushReplacementNamed(context, SingIn.routeName);
        },
        btnCancelOnPress: () {},
        body: const Text(
          'هل تريد تسجيل الخروج',
          style: TextStyle(
            fontSize: 17,
          ),
        )).show();
  }




}
