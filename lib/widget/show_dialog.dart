
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/server/api/update_api.dart';
import 'package:geo_route/utils/gap.dart';

class ShowDialog {
  static Future<void> displayUpdateDialog({required String title,required String id, required BuildContext context, required ValueChanged<String> onChanged, required TextEditingController textFieldController, required VoidCallback refreshData, required String? userInput}) async{

    showDialog(context: context, builder: (BuildContext context) {
      return Theme.of(context).platform == TargetPlatform.iOS ?
      CupertinoAlertDialog(

        title: Text(title),
        content: Column(
          children: [
            const Gap(10),
            CupertinoTextField(
              onChanged: onChanged,
              keyboardType: TextInputType.number,
              controller: textFieldController,
              placeholder: "Set new limit",
              style: const TextStyle(fontSize: 16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black, // Underline color
                    width: 1.0,        // Underline width
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(child: const Text('Cancel'), onPressed: (){
            textFieldController.clear();
            userInput = null;
            Navigator.of(context).pop();
          },),
          CupertinoDialogAction(child: const Text('Update'), onPressed: ()async{
            if(userInput != null && userInput!.isNotEmpty){
              await updateVehicleKmLimit(context: context, id: id, newLimit: int.parse(userInput!),refresh: refreshData);
              textFieldController.clear();
              userInput = null;
            }
          },)

        ],
      )
          : AlertDialog(

        title: Text(title),
        content: TextField(
          onChanged: onChanged,
          controller: textFieldController,
          keyboardType: TextInputType.number,

          decoration: const InputDecoration(hintText: "Set new limit"),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              textFieldController.clear();
              userInput = null;
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Update'),
            onPressed: () async {
                print("userInput");
              if (userInput != null && userInput!.isNotEmpty) {
                print(userInput);
                await updateVehicleKmLimit(context: context,
                    id: id,
                    newLimit: int.parse(userInput!),
                    refresh: refreshData);
                textFieldController.clear();
                userInput = null;
              }
            },
          ),
        ],
      );
    }
    );
  }
}