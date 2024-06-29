import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/server/api/authenticationApi.dart';
import 'package:geo_route/widget/CarCard.dart';

import 'VehicleListScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("CMD PATH",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        actions: [

          IconButton(onPressed: (){
            Authentication().handelUserLogout(context);
          }, icon: const Icon(Icons.notifications, color: Colors.black,)),
          const CircleAvatar( radius: 16),
          const SizedBox(width: 8)
        ],
        elevation: 1,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Vehicles:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: 10,
                itemBuilder: (context, index){
                  return GestureDetector(onTap: (){
                    if (Theme.of(context).platform == TargetPlatform.iOS) {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => const VehicleListScreen()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const VehicleListScreen()),
                      );
                    }                  },child: const CarCard());
                },
              )
            ],
          ),
        ),
      ),
        floatingActionButton:  FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: (){},
          child: const Icon(Icons.add,size: 36, color: Colors.white,),
        ),
    );

  }
}
