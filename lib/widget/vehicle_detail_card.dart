import 'package:flutter/material.dart';

class VehicleDetailScreenCard extends StatefulWidget {
  const VehicleDetailScreenCard({super.key});

  @override
  State<VehicleDetailScreenCard> createState() => _VehicleDetailScreenCardState();
}

class _VehicleDetailScreenCardState extends State<VehicleDetailScreenCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Card(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(3),topLeft: Radius.circular(3),)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.white,
        elevation: 5,
        child: Column(
          children: [
            Container(
              height: 30,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xff363333),
              ),
              child: const Center(
                child: Text("Distance", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18,),
                ),
              ),
            ),
            Stack(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text("Distance",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                              Text("40KM"),
                            ],
                          ),
                          SizedBox( height: 24, child: VerticalDivider(),),
                          Column(
                            children: [
                              Text("Run time",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                              Text("6hrs"),
                            ],
                          ),
                          SizedBox( height: 24, child: VerticalDivider(),),
                          Column(
                            children: [
                              Text("KM left",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                              Text("10KM"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25,),
                  ],
                ),
                Positioned(bottom:-5,right: 0, child: IconButton(onPressed: (){}, icon: const Icon(Icons.edit,size: 20,color: Colors.black,)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
