import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowDialog {
  Future<String?> showUpdateAlertDialog(BuildContext context, title) async {
    String textValue = '';
    showDialog(context: context, builder: (BuildContext context) {
      return Theme.of(context).platform == TargetPlatform.iOS ?
         CupertinoAlertDialog(
          title: Text(title),
          content: Column(
            children: [
              CupertinoTextField(
                placeholder: "Enter new value here",
                onChanged: (value){
                  textValue = value;
                },
              )
            ],
          ),
          actions: [
            CupertinoDialogAction(child: const Text('Cancel'), onPressed: (){
              Navigator.of(context).pop();
            },),
            CupertinoDialogAction(child: const Text('Save'), onPressed: (){
              Navigator.of(context).pop(textValue);
            },)

          ],
        )
      : AlertDialog(
          title: Text(title),
          content: TextField(
            decoration: const InputDecoration(hintText: 'Enter your value here'),
            onChanged: (value){
              textValue = value;
            },
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Insert'),
              onPressed: () {
                Navigator.of(context).pop(textValue);
              },
            ),
          ],
        );
      }
    );
  }
}