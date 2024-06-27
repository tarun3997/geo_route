import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  const CarCard({super.key});

  final TextStyle textStyle = const TextStyle(fontWeight: FontWeight.w600, fontSize: 16);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: MediaQuery.of(context).size.width /2,
        height: 50,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset("assets/bike.png",width: 110,),
            Column(
              children: [
                Text("All Vehicle",style: textStyle,),
                Text("28", style: textStyle,)
              ],
            )

          ],
        ),
      ),
    );
  }
}
