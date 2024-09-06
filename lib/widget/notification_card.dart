import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.vehicleNumber,
    required this.title,
    required this.time,
    required this.body,
  });

  final String vehicleNumber;
  final String title;
  final String body;
  final String time;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(
                  "https://t3.ftcdn.net/jpg/01/93/90/82/360_F_193908219_ak4aB1PzlhizUVGLOVowzHICc3tl6WeX.jpg",
                ),
              ),
              const SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(title, style:  const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    )),
                    Text.rich(
                      softWrap: true,
                    TextSpan(

                      text: "$vehicleNumber:",
                        style:  const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                        children: [
                        TextSpan(
                          text: body,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                        )
                      ]
                    ),
                    ),
                    Text(time, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xff555559)),)
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}