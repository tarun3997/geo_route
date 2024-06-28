
import 'package:flutter/material.dart';
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child:   Column(
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
            const SizedBox(height: 14,),
            const VehicleDetailsCard()

          ],
        ),
      ),
    );
  }
}
