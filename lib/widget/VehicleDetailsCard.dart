import 'package:flutter/material.dart';

class VehicleDetailsCard extends StatefulWidget {
  const VehicleDetailsCard({super.key});

  @override
  State<VehicleDetailsCard> createState() => _VehicleDetailsCardState();
}

class _VehicleDetailsCardState extends State<VehicleDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),]
      ),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 11,),
              Image.asset("assets/bike.png",width: 60,),
              const SizedBox(width: 10,),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("RJ30 2467", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                Text("In-Active",style: TextStyle(fontSize: 12),),
              ],)
            ],
          )
        ],
      ),
    );
  }
}
