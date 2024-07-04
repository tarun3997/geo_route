import 'package:flutter/material.dart';

class VehicleDetailsScreen extends StatefulWidget {
  const VehicleDetailsScreen({super.key});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MAP"),elevation: 5,shadowColor: Colors.grey,),
      body: Stack(
          children: [
            Container(
              color: Colors.red,
              height: MediaQuery.of(context).size.height,
            ),
            DraggableScrollableSheet(
                initialChildSize: 0.4,
                minChildSize: 0.4,
                builder: (context, scrollController){
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 17,),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(radius: 15,),
                              SizedBox(width: 10,),
                              Text("Deshraj Singh Rana",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.5,
                            color: Colors.black,
                            indent: MediaQuery.of(context).size.width/6,
                            endIndent: MediaQuery.of(context).size.width/6,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
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
                                      child: Text("Vehicle", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18,),
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
                                                    Text("Number",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                                                    Text("RJ30 4521"),
                                                  ],
                                                ),
                                                SizedBox( height: 24, child: VerticalDivider(),),
                                                Column(
                                                  children: [
                                                    Text("Vehicle type",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                                                    Text("Truck"),
                                                  ],
                                                ),
                                                SizedBox( height: 24, child: VerticalDivider(),),
                                                Column(
                                                  children: [
                                                    Text("Fuel type",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                                                    Text("Diesel"),
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
                          ),
                          Padding(
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
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
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
                                      child: Text("Vehicle", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18,),
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
                                                    Text("Number",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                                                    Text("RJ30 4521"),
                                                  ],
                                                ),
                                                SizedBox( height: 24, child: VerticalDivider(),),
                                                Column(
                                                  children: [
                                                    Text("Vehicle type",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                                                    Text("Truck"),
                                                  ],
                                                ),
                                                SizedBox( height: 24, child: VerticalDivider(),),
                                                Column(
                                                  children: [
                                                    Text("Fuel type",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                                                    Text("Diesel"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 25,),
                                        ],
                                      ),
                                      Positioned(bottom:-5,right: 0, child: IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 20,color: Colors.black,)))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
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
                                      Positioned(bottom:-5,right: 0, child: IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 20,color: Colors.black,)))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
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
                                      child: Text("Vehicle", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18,),
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
                                                    Text("Number",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                                                    Text("RJ30 4521"),
                                                  ],
                                                ),
                                                SizedBox( height: 24, child: VerticalDivider(),),
                                                Column(
                                                  children: [
                                                    Text("Vehicle type",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                                                    Text("Truck"),
                                                  ],
                                                ),
                                                SizedBox( height: 24, child: VerticalDivider(),),
                                                Column(
                                                  children: [
                                                    Text("Fuel type",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                                                    Text("Diesel"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 25,),
                                        ],
                                      ),
                                      Positioned(bottom:-5,right: 0, child: IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 20,color: Colors.black,)))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
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
                                      Positioned(bottom:-5,right: 0, child: IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 20,color: Colors.black,)))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
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
                                      child: Text("Vehicle", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18,),
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
                                                    Text("Number",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                                                    Text("RJ30 4521"),
                                                  ],
                                                ),
                                                SizedBox( height: 24, child: VerticalDivider(),),
                                                Column(
                                                  children: [
                                                    Text("Vehicle type",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                                                    Text("Truck"),
                                                  ],
                                                ),
                                                SizedBox( height: 24, child: VerticalDivider(),),
                                                Column(
                                                  children: [
                                                    Text("Fuel type",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                                                    Text("Diesel"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 25,),
                                        ],
                                      ),
                                      Positioned(bottom:-5,right: 0, child: IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 20,color: Colors.black,)))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
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
                                      Positioned(bottom:-5,right: 0, child: IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 20,color: Colors.black,)))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            )
          ]
      ),
    );
  }
}