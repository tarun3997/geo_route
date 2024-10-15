import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  const   CarCard({super.key, required this.image, required this.cardTitle, required this.count});

  final String? image;
  final String? cardTitle;
  final int? count;
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
            Image.asset('assets/$image',width: 110,),
            Column(
              children: [
                Text(cardTitle!,style: textStyle,),
                Text("${count ?? ""}", style: textStyle,)
              ],
            )

          ],
        ),
      ),
    );
  }
}
