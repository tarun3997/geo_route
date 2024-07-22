import 'package:flutter/material.dart';
import 'package:geo_route/widget/NotificationCard.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String message = "";
  @override
  void didChangeDependencies(){
    final argument = ModalRoute.of(context)!.settings.arguments;
    if(argument != null){
      Map? pushArgument = argument as Map;

      setState(() {
        message = pushArgument["message"];
      });
    }
  }
  Map<String, Map> notifications = {
    'alert1': {
      'vehicleNo': 'RJ27CA6453',
      'info': 'You have crossed 80% limit with 7000KM'
    },
    'alert2': {
      'vehicleNo': 'MH14AB1234',
      'info': 'You have crossed 90% limit with 15000KM'
    },
    'alert3': {
      'vehicleNo': 'KA01CD5678',
      'info': 'You have crossed 90% limit with 15000KM'
    },
    'alert4': {
      'vehicleNo': 'TN22EF9012',
      'info': 'You have crossed 85% limit with 12000KM'
    },
    'alert5': {
      'vehicleNo': 'UP34GH5678',
      'info': 'You have crossed 95% limit with 18000KM'
    },
    'alert6': {
      'vehicleNo': 'AP45IJ2345',
      'info': 'You have crossed 80% limit with 10000KM'
    },
    'alert7': {
      'vehicleNo': 'KL56MN3456',
      'info': 'You have crossed 90% limit with 16000KM'
    },
    'alert8': {
      'vehicleNo': 'WB67OP4567',
      'info': 'You have crossed 85% limit with 13000KM'
    },
    'alert9': {
      'vehicleNo': 'MP78QR5678',
      'info': 'You have crossed 95% limit with 19000KM'
    },
    'alert10': {
      'vehicleNo': 'RJ89ST9012',
      'info': 'You have crossed 80% limit with 11000KM'
    },
    'alert11': {
      'vehicleNo': 'MH90UV2345',
      'info': 'You have crossed 90% limit with 17000KM'
    },
    'alert12': {
      'vehicleNo': 'KA01WX3456',
      'info': 'You have crossed 85% limit with 14000KM'
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.grey,
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          String key = notifications.keys.elementAt(index);
          return NotificationCard(
              vehicleNumber: notifications[key]!['vehicleNo'].toString(),
              alertInfo: notifications[key]!['info'].toString()
          );
        },
      ),
    );
  }
}
