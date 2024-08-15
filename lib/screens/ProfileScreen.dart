import 'dart:ffi';

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final Map<String, Map<String, dynamic>> data = {

  };

  final TextStyle mainStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20);
  final TextStyle subStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70);
  final double mileage = 4.5;// (totalDistance-lastDistanceTravelBeforeFuelFilled)/FuelFilled;
  final double avgSpeed = 55;// (totalDistance-lastDistanceTravel)/runTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Card(
              elevation: 2,
              clipBehavior: Clip.hardEdge,
              child: Container(
                color: const Color(0xff363333),
                width: MediaQuery.sizeOf(context).width,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("DEvRaj",
                      style: mainStyle,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12,),
            Card(
              elevation: 2,
              clipBehavior: Clip.hardEdge,
              child: Container(
                color: const Color(0xff363333),
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Safari",style: mainStyle,),
                              Text("Updated at 6.32AM",style: subStyle,),
                            ],
                          ),
                          const SizedBox(width: 20,),
                          Text("Petrol",style: mainStyle,),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text("${mileage}km/l",style: mainStyle,),
                              Text("Mileage",style: subStyle,),
                            ],
                          ),
                          Column(
                            children: [
                              Text("${avgSpeed}km/h",style: mainStyle,),
                              Text("Avg. Speed",style: subStyle,),
                            ],
                          ),
                          Column(
                            children: [
                              Text("40Litre",style: mainStyle,),
                              Text("Fuel Filled",style: subStyle,),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12,),
            Card(
              elevation: 2,
              clipBehavior: Clip.hardEdge,
              child: Container(
                color: const Color(0xff363333),
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Distance", style: mainStyle,),
                      rowValue(text: "Distance", value: 40, postfix: "KM"),
                      rowValue(text: "Run Time", value: 06, postfix: "hrs"),
                      rowValue(text: "Remaining", value: 10, postfix: "KM"),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12,),
            Card(
              clipBehavior: Clip.hardEdge,
              child: Container(
                color: const Color(0xff363333),
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Vehicle Number", style: mainStyle,),
                      Text("RJ30 BL 4241", style: mainStyle,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget rowValue ({required String text, required int value, required String postfix}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: subStyle,),
        Text.rich(
          TextSpan(
            text: "$value",
            style: mainStyle,
            children: [
              TextSpan(
                text: postfix,
                style: subStyle,
              ),
            ]
          ),
        ),
      ],
    );
  }
}
