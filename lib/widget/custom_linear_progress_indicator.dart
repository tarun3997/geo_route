import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final String vehicleNewKm;
  final String vehicleKMLimit;
  const CustomLinearProgressIndicator({super.key, required this.vehicleNewKm, required this.vehicleKMLimit});

  @override
  Widget build(BuildContext context) {
    final List limitColor = [const AlwaysStoppedAnimation<Color>(Colors.green),const AlwaysStoppedAnimation<Color>(Colors.yellow),const AlwaysStoppedAnimation<Color>(Colors.red),];
    int colorIndex = 0;
    final totalRun = double.parse(vehicleNewKm);
    final limit = double.parse(vehicleKMLimit);
    colorIndex = ((5080/ 6000) * 2).round();
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$vehicleNewKm Km"),
              Text("$vehicleKMLimit Km"),
            ],
          ),
          LinearProgressIndicator(
            value: totalRun / limit, // total run/limit

            valueColor: limitColor[colorIndex],
          ),
        ],
      ),
    );
  }
}
