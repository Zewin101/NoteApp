import 'package:flutter/material.dart';
import 'package:noteapp/generated/assets.dart';

class CardNotes extends StatelessWidget {
  final String Title;
  final String Content;
  final void Function()? ontap;

  const CardNotes(
      {Key? key,
      required this.Title,
      required this.Content,
      required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
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
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text(Title),
                  subtitle: Text(Content),
                )),
          ],
        ),
      ),
    );
  }
}
