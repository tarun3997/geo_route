import 'package:flutter/material.dart';
import 'package:geo_route/utils/gap.dart';
import 'package:geo_route/widget/show_dialog.dart';
import 'package:geo_route/widget/vehicle_card_data.dart';

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
              ShowDialog.displayUpdateDialog(title: "Edit vehicle KM limit",id: widget.vehicleId, context: context,onChanged: (value){
                setState(() {
                  userInput = value;
                });
              }, textFieldController: _textFieldController,refreshData: widget.refreshData, userInput: userInput);
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
