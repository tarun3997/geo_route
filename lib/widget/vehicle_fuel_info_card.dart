import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/model/vehicle_details_model.dart';
import 'package:geo_route/widget/snack_bar.dart';
import 'package:geo_route/widget/vehicle_card_data.dart';

import '../server/api/update_api.dart';
import '../utils/gap.dart';

class VehicleFuelInfoCard extends StatefulWidget {
  final VehicleDetailsModel vehicleDetails;
  final String vehicleId;
  final VoidCallback refreshData;

  const VehicleFuelInfoCard(
      {super.key,
      required this.vehicleDetails,
      required this.vehicleId,
      required this.refreshData});

  @override
  State<VehicleFuelInfoCard> createState() => _VehicleFuelInfoCardState();
}

class _VehicleFuelInfoCardState extends State<VehicleFuelInfoCard> {
  final TextEditingController _fuelController = TextEditingController();
  final TextEditingController _kmController = TextEditingController();
  String? fuelInput;
  String? kmInput;

  Future<void> displayUpdateDialog(
      {required String title, required String id}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme.of(context).platform == TargetPlatform.iOS
              ? CupertinoAlertDialog(
                  title: Text(title),
                  content: Column(
                    children: [
                      const Gap(10),
                      CupertinoTextField(
                        onChanged: (value) {
                          setState(() {
                            fuelInput = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        controller: _fuelController,
                        placeholder: "reFuel filled amount",
                        style: const TextStyle(fontSize: 16),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black, // Underline color
                              width: 1.0, // Underline width
                            ),
                          ),
                        ),
                      ),
                      CupertinoTextField(
                        onChanged: (value) {
                          setState(() {
                            kmInput = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        controller: _kmController,
                        placeholder: "Vehicle km",
                        style: const TextStyle(fontSize: 16),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black, // Underline color
                              width: 1.0, // Underline width
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('Cancel'),
                      onPressed: () {
                        _fuelController.clear();
                        fuelInput = null;
                        kmInput = null;
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoDialogAction(
                      child: const Text('Update'),
                      onPressed: () async {
                        if (fuelInput != null &&
                            fuelInput!.isNotEmpty &&
                            kmInput != null &&
                            kmInput!.isNotEmpty) {
                          await updateVehicleFuel(
                              context: context,
                              id: id,
                              newFuelEntered: double.parse(fuelInput!),
                              vehicleRunKM: double.parse(kmInput!),
                              refresh: widget.refreshData);
                          _fuelController.clear();
                          fuelInput = null;
                          kmInput = null;
                        }
                      },
                    )
                  ],
                )
              : AlertDialog(
                  title: Text(title),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              fuelInput = value;
                            });
                          },
                          controller: _fuelController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: "reFuel filled amount"),
                        ),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              kmInput = value;
                            });
                          },
                          controller: _kmController,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(hintText: "Vehicle KM"),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        _fuelController.clear();
                        _kmController.clear();
                        fuelInput = null;
                        kmInput = null;
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Update'),
                      onPressed: () async {
                        if (fuelInput != null &&
                            fuelInput!.isNotEmpty &&
                            kmInput != null &&
                            kmInput!.isNotEmpty) {
                          await updateVehicleFuel(
                              context: context,
                              id: id,
                              newFuelEntered: double.parse(fuelInput!),
                              vehicleRunKM: double.parse(kmInput!),
                              refresh: widget.refreshData,);
                          _fuelController.clear();
                          _kmController.clear();
                          fuelInput = null;
                          kmInput = null;
                        }
                        Navigator.pop(context);
                        showSnackBar(context, Colors.green, "Updated");
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
        });
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
                "Fuel Info",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                VehicleCardData(
                    title: "Refueled on",
                    value: widget.vehicleDetails.refuelDate ?? "-/-/-",
                    type: widget.vehicleDetails.vehicleFuelType ?? "unknown"),
                const SizedBox(
                  height: 24,
                  child: VerticalDivider(),
                ),
                VehicleCardData(
                    title: "Fuel available",
                    value: "${widget.vehicleDetails.fuelAmount}",
                    type: widget.vehicleDetails.vehicleFuelType ?? "unknown"),
                const SizedBox(
                  height: 24,
                  child: VerticalDivider(),
                ),
                VehicleCardData(
                    title: "Mileage",
                    value: "${widget.vehicleDetails.mileage}",
                    type: "kmpl"),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              displayUpdateDialog(title: "Edit Fuel", id: widget.vehicleId);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Edit Fuel",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 12,
                ),
              ],
            ),
          ),
          const Gap(6)
        ],
      ),
    );
  }
}
