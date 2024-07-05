import 'package:flutter/material.dart';
import 'package:geo_route/widget/VehicleDetailCard.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';


class VehicleDetailsScreen extends StatefulWidget {
  const VehicleDetailsScreen({super.key});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {

  @override
  void initState() {
    MapmyIndiaAccountManager.setMapSDKKey("19447b84be06954492dce18a5abbc654");
    MapmyIndiaAccountManager.setRestAPIKey("19447b84be06954492dce18a5abbc654");
    MapmyIndiaAccountManager.setAtlasClientId("96dHZVzsAuvPF322Zvhn9pRNquQizpxDitB6faHTrwJg2yEO1EEb5rnRLcEBAKip34-4hpVk0Pubjtsz49SLdGW08B6fJWzm");
    MapmyIndiaAccountManager.setAtlasClientSecret("lrFxI-iSEg9ZcqIkAkL3JWJfL7vTBwUpUqBnKgTADRHTzvDzXpaBl_yYz6TYqjCZJ8k84mDlbjDl5yCHfBICvciQPx8f_t7hGI1l1midBmM=");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MAP"), elevation: 5, shadowColor: Colors.grey,),
      body: Stack(
          children: [
            Container(
                color: Colors.red,
                height: MediaQuery.of(context).size.height,
                child: MapmyIndiaMap(

                  initialCameraPosition: const CameraPosition(
                      target: LatLng(24.594872, 73.72804),
                      zoom: 14.0
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: DraggableScrollableSheet(
                  initialChildSize: 0.4,
                  minChildSize: 0.4,
                  builder: (context, scrollController) {
                    return Container(
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
                            indent: MediaQuery.of(context).size.width / 6,
                            endIndent: MediaQuery.of(context).size.width / 6,
                          ),
                          // Use a fixed height for the ListView
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                controller: scrollController, // Use the same scroll controller
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return const VehicleDetailScreenCard(); // Assuming this is the correct widget
                                }
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            )
          ]
      ),
    );
  }
}