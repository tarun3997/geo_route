import 'package:flutter/material.dart';

class VehicleCardData extends StatelessWidget {
  final String title;
  final String value;
  final String type;
  const VehicleCardData({super.key, required this.title, required this.value, required this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
        ),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        Text(type),
      ],
    );;
  }
}
