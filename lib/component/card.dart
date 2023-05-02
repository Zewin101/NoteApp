import 'package:flutter/material.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/generated/assets.dart';

class CardNotes extends StatelessWidget {
  final String title;
  final String content;
  final String image;
  final void Function()? onTap;
  final void Function()? delete;

  const CardNotes(
      {Key? key,
      required this.title,
      required this.content,
      required this.onTap,
      required this.delete,
      required this.image,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(

        elevation: 20,
        child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Image.network(
                      '$linkUpLoadImages$image',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                )),
                Expanded(
                    flex: 2,
                    child: ListTile(
                      title: Text(title),
                      subtitle: Text(content),
                    )),
                const SizedBox(width: 5,),
                IconButton(onPressed: delete, icon: const Icon(Icons.delete)),
              ],
            ),
      ),
    );
  }
}
