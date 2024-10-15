import 'package:flutter/material.dart';
import 'package:geo_route/model/vehicle_details_model.dart';
import 'package:geo_route/widget/vehicle_card_data.dart';

class VehicleFuelInfoCard extends StatelessWidget {
  final VehicleDetailsModel vehicleDetails;

  const VehicleFuelInfoCard({super.key, required this.vehicleDetails});

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
                "Fuel Info",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,

                  fontSize: 18,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                VehicleCardData(title: "Refueled on", value: "27/08/2024", type:""),
                SizedBox(
                  height: 24,
                  child: VerticalDivider(),
                ),
                VehicleCardData(title: "Mileage", value: "18", type: "kmpl"),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
