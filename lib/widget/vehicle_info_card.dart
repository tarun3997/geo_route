import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/utils/gap.dart';
import 'package:geo_route/widget/vehicle_card_data.dart';

import '../server/api/update_api.dart';

class VehicleInfoCard extends StatefulWidget {
  final String vehicleRunKM;
  final String vehicleLimitLeft;
  final String vehicleKMLimit;
  final String vehicleId;
  final VoidCallback refreshData;
  const VehicleInfoCard({super.key, required this.vehicleRunKM, required this.vehicleLimitLeft, required this.vehicleKMLimit, required this.refreshData, required this.vehicleId});

  @override
  State<VehicleInfoCard> createState() => _VehicleInfoCardState();
}

class _VehicleInfoCardState extends State<VehicleInfoCard> {
  final TextEditingController _textFieldController = TextEditingController();
  String? userInput;

  Future<void> displayUpdateDialog({required String title,required String id}) async{
    showDialog(context: context, builder: (BuildContext context) {
      return Theme.of(context).platform == TargetPlatform.iOS ?
      CupertinoAlertDialog(

        title: Text(title),

        content: Column(
          children: [
            const Gap(10),
            CupertinoTextField(
              onChanged: (value) {
                setState(() {
                  userInput = value;
                });
              },
              keyboardType: TextInputType.number,
              controller: _textFieldController,
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
            _textFieldController.clear();
            userInput = null;
            Navigator.of(context).pop();
          },),
          CupertinoDialogAction(child: const Text('Update'), onPressed: ()async{
            if(userInput != null && userInput!.isNotEmpty){
              await updateVehicleKmLimit(context: context, id: id, newLimit: int.parse(userInput!),refresh: widget.refreshData);
              _textFieldController.clear();
              userInput = null;
            }
          },)

        ],
      )
          : AlertDialog(

        title: Text(title),
        content: TextField(
          onChanged: (value) {
            setState(() {
              userInput = value;
            });
          },
          controller: _textFieldController,
          keyboardType: TextInputType.number,

          decoration: const InputDecoration(hintText: "Set new limit"),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              _textFieldController.clear();
              userInput = null;
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Update'),
            onPressed: () async {
              if (userInput != null && userInput!.isNotEmpty) {
                await updateVehicleKmLimit(context: context,
                    id: id,
                    newLimit: int.parse(userInput!),
                    refresh: widget.refreshData);
                _textFieldController.clear();
                userInput = null;
              }
            },
          ),
        ],
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(3),
          topLeft: Radius.circular(3),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      elevation: 2,
      child: Column(
        children: [
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xff363333),
            ),
            child: const Center(
              child: Text(
                "Vehicle Info",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                VehicleCardData(title: "Total Run", value: widget.vehicleRunKM, type:"Km"),
                const SizedBox(
                  height: 24,
                  child: VerticalDivider(),
                ),
                VehicleCardData(title: "Limit Left", value: widget.vehicleLimitLeft, type: "Km"),
                const SizedBox(
                  height: 24,
                  child: VerticalDivider(),
                ),
                VehicleCardData(title: "Limit", value: widget.vehicleKMLimit, type:"Km" )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              displayUpdateDialog(title: "Edit vehicle KM limit",id: widget.vehicleId);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Edit Limit", style: TextStyle(fontWeight: FontWeight.bold),),
                Icon(Icons.arrow_forward_ios_outlined, size: 12,),
              ],
            ),
          ),
          const Gap(6)
        ],
      ),
    );
  }
}
