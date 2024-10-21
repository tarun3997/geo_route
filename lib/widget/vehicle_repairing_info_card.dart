import 'package:flutter/material.dart';
import 'package:geo_route/server/api/vehicle_repairing_api.dart';
import 'package:geo_route/widget/snack_bar.dart';

import '../model/vehicle_details_model.dart';

class VehicleRepairingInfoCard extends StatelessWidget {
  final VehicleDetailsModel vehicleDetails;
  final VoidCallback onRepairDone;
  const VehicleRepairingInfoCard({super.key, required this.vehicleDetails, required this.onRepairDone});

  @override
  Widget build(BuildContext context) {
    return  Card(
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
            padding: const EdgeInsets.symmetric(vertical: 6),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xff363333),
            ),
            child: const Center(
              child: Text(
                "This vehicle is under repairing",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              children: [
                ListTile(
                  title: Text("Damage Part: ${vehicleDetails.damagePart}"),
                  subtitle: Text("Reason: ${vehicleDetails.vehicleReason}, ${vehicleDetails.description}"),
                  contentPadding: EdgeInsets.zero,
                  minTileHeight: 0,
                  isThreeLine: true,
                ),
                GestureDetector(
                  onTap: (){
                    VehicleRepairingApi().handelVehicleRepairDone(id: vehicleDetails.id!, context: context, onRepairDone: onRepairDone);
                    showSnackBar(context, Colors.green, "repaired Successfully");
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Repair Done", style: TextStyle(fontWeight: FontWeight.bold),),
                      Icon(Icons.arrow_forward_ios_outlined, size: 12,),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
