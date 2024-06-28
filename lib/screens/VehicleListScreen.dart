import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/enums/VehicleType.dart';
import 'package:geo_route/model/VehicleShortDetailModel.dart';
import 'package:geo_route/widget/VehicleDetailsCard.dart';

class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen({super.key});

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }
  final List<VehicleShortDetailModel> vehicleDetails = [
    VehicleShortDetailModel(
      type: VehicleType.bike,
      vehicleNumber: "RJ30CA3997",
      distance: 30.0,
      runTime: 20,
      currentLocation: "Parshal highway side road, pune maharashtra",
      remainingKm: 10,
      todayKm: 2.5,
    ),
    VehicleShortDetailModel(
      type: VehicleType.car,
      vehicleNumber: "MH12AB1234",
      distance: 50.0,
      runTime: 30,
      currentLocation: "Katraj highway, pune maharashtra",
      remainingKm: 20,
      todayKm: 5.0,
    ),
    VehicleShortDetailModel(
      type: VehicleType.truck,
      vehicleNumber: "GJ01CD5678",
      distance: 100.0,
      runTime: 45,
      currentLocation: "Nagar road, pune maharashtra",
      remainingKm: 30,
      todayKm: 10.0,
    ),
    VehicleShortDetailModel(
      type: VehicleType.truck,
      vehicleNumber: "UP90EF9012",
      distance: 200.0,
      runTime: 60,
      currentLocation: "Solapur highway, pune maharashtra",
      remainingKm: 40,
      todayKm: 15.0,
    ),
    VehicleShortDetailModel(
      type: VehicleType.bike,
      vehicleNumber: "RJ45GH6789",
      distance: 25.0,
      runTime: 18,
      currentLocation: "Aundh road, pune maharashtra",
      remainingKm: 12,
      todayKm: 3.0,
    ),
    VehicleShortDetailModel(
      type: VehicleType.car,
      vehicleNumber: "MH67IJ3456",
      distance: 70.0,
      runTime: 35,
      currentLocation: "Baner road, pune maharashtra",
      remainingKm: 25,
      todayKm: 7.0,
    ),
  ];
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  final TextStyle textStyle = const TextStyle(fontSize: 18,color: Colors.black, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_rounded)),
        title: const Text("All Vehicles", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){

          }, icon: const Icon(Icons.search, color: Colors.black,)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child:   SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,

            child: Column(
              children: [
              TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              indicatorColor: Colors.black,
              indicator: const UnderlineTabIndicator(
                borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black,width: 3)

              ),
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 12),
              controller: tabController,
              tabs: [
                Tab(child: Text("Car", style: textStyle,),),
                Tab(child: Text("Bike", style: textStyle,)),
                Tab(child: Text("Truck", style: textStyle,)),
              ],
            ),
                Flexible(

                  child: TabBarView(
                    controller: tabController,
                    children: [
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: vehicleDetails.where((vehicle) => vehicle.type == VehicleType.car).length,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            final vehicle = vehicleDetails.where((vehicle) => vehicle.type == VehicleType.car).elementAt(index);
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: VehicleDetailsCard(
                                type: vehicle.type,
                                currentLocation: vehicle.currentLocation,
                                distance: vehicle.distance,
                                remainingKm: vehicle.remainingKm,
                                runTime: vehicle.runTime,
                                todayKm: vehicle.todayKm,
                                vehicleNumber: vehicle.vehicleNumber,
                              ),
                            );
                          }
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: vehicleDetails.where((vehicle) => vehicle.type == VehicleType.bike).length,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            final vehicle = vehicleDetails.where((vehicle) => vehicle.type == VehicleType.bike).elementAt(index);
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: VehicleDetailsCard(
                                type: vehicle.type,
                                currentLocation: vehicle.currentLocation,
                                distance: vehicle.distance,
                                remainingKm: vehicle.remainingKm,
                                runTime: vehicle.runTime,
                                todayKm: vehicle.todayKm,
                                vehicleNumber: vehicle.vehicleNumber,
                              ),
                            );
                          }
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: vehicleDetails.where((vehicle) => vehicle.type == VehicleType.truck).length,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            final vehicle = vehicleDetails.where((vehicle) => vehicle.type == VehicleType.truck).elementAt(index);
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: VehicleDetailsCard(
                                type: vehicle.type,
                                currentLocation: vehicle.currentLocation,
                                distance: vehicle.distance,
                                remainingKm: vehicle.remainingKm,
                                runTime: vehicle.runTime,
                                todayKm: vehicle.todayKm,
                                vehicleNumber: vehicle.vehicleNumber,
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
