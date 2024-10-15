import 'package:flutter/material.dart';
import 'package:geo_route/enums/vehicle_type.dart';
import 'package:geo_route/screens/vehicle_details_screen.dart';
import 'package:geo_route/utils/navigation_utils.dart';

class VehicleDetailsCard extends StatefulWidget {
  final String id;
  final VehicleType? type;
  final String? vehicleNumber;
  final int? distance;
  final int? runTime;
  final int? remainingKm;
  final String? currentLocation;
  final int? todayKm;
  final String? updatedTime;
  final double lat;
  final double lng;
  final bool isActive;
  final bool repairing;
  const VehicleDetailsCard({super.key, this.updatedTime, this.type ,this.vehicleNumber, this.distance, this.runTime, this.remainingKm, this.currentLocation, this.todayKm, required this.lat, required this.lng, required this.isActive, required this.id, required this.repairing});

  @override
  State<VehicleDetailsCard> createState() => _VehicleDetailsCardState();
}

class _VehicleDetailsCardState extends State<VehicleDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        NavigationUtils.navigatorPush(context, VehicleDetailsScreen(id: widget.id, isRepairing: widget.repairing,));
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),]
        ),
        width: MediaQuery.of(context).size.width,

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 11,),
                      Image.asset("assets/${widget.type.toString().split('.').last}.png",width: 60,),
                      const SizedBox(width: 10,),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("${widget.vehicleNumber}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          Text(widget.isActive ?  "Active" : "Not-Active",style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),),
                      ],)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Condition",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        widget.repairing
                            ? const Text("Under Repairing",style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),)
                            : const Text("Good",style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  shortDetails(title: "Distance", value: "${widget.distance}Km"),
                  const SizedBox(
                    height: 24,
                    child: VerticalDivider(),
                  ),
                  shortDetails(title: "Run Time", value: "${widget.runTime} hrs"),
                  const SizedBox(
                    height: 24,
                    child: VerticalDivider(),
                  ),
                  shortDetails(title: "Remaining Km", value: "${widget.remainingKm}Km"),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xff363333),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.location_on_outlined, color: Colors.white,size: 28,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width /1.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${widget.currentLocation}",style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                        Text("updated at ${widget.updatedTime}",style: const TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Text("Today",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      Text("${widget.todayKm}",style: const TextStyle(color: Color(0xff99AA41))),
                      const Text("Km",style: TextStyle(color: Color(0xff99AA41))),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget shortDetails({required String title, required String value }){
  return  Column(
    children: [
      Text(title,style: const TextStyle(fontWeight: FontWeight.w600),),
      Text(value),
    ],
  );
}
