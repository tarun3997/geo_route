import 'package:flutter/material.dart';
import 'package:geo_route/utils/gap.dart';

class VehicleImpInfo extends StatelessWidget {
  final String vehicleImg;
  final String vehicleName;
  final String isActive;
  final String fuelType;
  final String id;
  final String location;
  const VehicleImpInfo({super.key, required this.vehicleImg, required this.vehicleName, required this.isActive, required this.fuelType, required this.id, required this.location});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(vehicleImg,width: 54,),
                const SizedBox(width: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(vehicleName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                    Text(isActive, style: const TextStyle(fontSize: 12),),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.local_gas_station_outlined, size: 18,),
                    Text(":- $fuelType", style: const TextStyle(fontSize: 12),)
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.sim_card_outlined, size: 18,),
                    Text(":- $id", style: const TextStyle(fontSize: 12),)
                  ],
                ),
              ],
            ),

          ],
        ),
        const Gap(16),
        Row(
          children: [
            const Icon(Icons.location_on_outlined),
            const SizedBox(width: 8,),
            Expanded(
              child: Text(
                location,
                overflow: TextOverflow.visible,
                softWrap: true,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
