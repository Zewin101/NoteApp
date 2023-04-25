import 'package:flutter/material.dart';
import 'package:noteapp/generated/assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            InkWell(
              onTap: (){},
              child: Card(
                elevation: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Image.asset(
                      Assets.imageLogo,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    )),
                    const Expanded(
                        flex: 2,
                        child: ListTile(
                          title: Text('Title Note'),
                          subtitle: Text('Content Note'),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
