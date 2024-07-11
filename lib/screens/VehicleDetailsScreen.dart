import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/model/VehicleDetailsModel.dart';
import 'package:geo_route/server/api/vehicleApi.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:url_launcher/url_launcher.dart';

class VehicleDetailsScreen extends StatefulWidget {
  final String id;
  const VehicleDetailsScreen({super.key, required this.id});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  late MapmyIndiaMapController _mapController;

  final VehicleApi vehicleApi = VehicleApi();
  late Future<VehicleDetailsModel> vehicleDetailsFuture;

  @override
  void initState() {
    MapmyIndiaAccountManager.setMapSDKKey("19447b84be06954492dce18a5abbc654");
    MapmyIndiaAccountManager.setRestAPIKey("19447b84be06954492dce18a5abbc654");
    MapmyIndiaAccountManager.setAtlasClientId(
        "96dHZVzsAuvPF322Zvhn9pRNquQizpxDitB6faHTrwJg2yEO1EEb5rnRLcEBAKip34-4hpVk0Pubjtsz49SLdGW08B6fJWzm");
    MapmyIndiaAccountManager.setAtlasClientSecret(
        "lrFxI-iSEg9ZcqIkAkL3JWJfL7vTBwUpUqBnKgTADRHTzvDzXpaBl_yYz6TYqjCZJ8k84mDlbjDl5yCHfBICvciQPx8f_t7hGI1l1midBmM=");
    vehicleDetailsFuture = vehicleApi.getVehicleDetailsById(id: widget.id);
    super.initState();
  }

  void _onMapCreated(MapmyIndiaMapController controller) async {
    _mapController = controller;
    final vehicleDetails = await vehicleDetailsFuture;
    _addMarker(lat: vehicleDetails.lat, lng: vehicleDetails.lng);
  }

  void _addMarker({required double lat, required double lng}) {
    _mapController.addSymbol(SymbolOptions(
      geometry: LatLng(lat, lng),
      iconImage: "assets/marker.png",
      iconSize: 0.25,
    ));
  }

  Future<void> _openMap({required double latitude, required double longitude}) async {
    Uri url;
    if (Platform.isIOS) {
      url = Uri.parse('https://maps.apple.com/?daddr=$latitude,$longitude&dirflg=d');
    } else {
      url = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving');
    }

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      vehicleDetailsFuture = vehicleApi.getVehicleDetailsById(id: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MAP"),
        centerTitle: true,
        elevation: 5,
        shadowColor: Colors.grey,
        actions: [
          IconButton(onPressed: _refreshData, icon: const Icon(Icons.refresh, size: 28,))
        ],
      ),
      body: FutureBuilder<VehicleDetailsModel>(
        future: vehicleDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? const CupertinoActivityIndicator(radius: 20)
                  : const CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No data found"));
          } else {
            final vehicleDetails = snapshot.data!;
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: MapmyIndiaMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(vehicleDetails.lat, vehicleDetails.lng),
                      zoom: 15.0,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: GestureDetector(
                    onTap: () => _openMap(latitude: vehicleDetails.lat, longitude: vehicleDetails.lng),
                    child: const CircleAvatar(
                      backgroundColor: Colors.black87,
                      radius: 18,
                      child: Icon(Icons.directions, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.4,
                    minChildSize: 0.4,
                    builder: (context, scrollController) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
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
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 17),
                            Text(
                              vehicleDetails.driverName ?? "Unknown driver",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Divider(
                              thickness: 1.5,
                              color: Colors.black,
                              indent: MediaQuery.of(context).size.width / 6,
                              endIndent: MediaQuery.of(context).size.width / 6,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: Column(
                                  children: [
                                    vehicleDetailCard(
                                        context: context,
                                        title: "Current Status"),
                                    vehicleDetailCard(
                                        context: context, title: "Vehicle"),
                                    vehicleDetailCard(
                                        context: context, title: "Distance"),
                                    vehicleDetailCard(
                                        context: context, title: "GPS"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

Widget vehicleDetailCard({required BuildContext context, required String title}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(3),
          topLeft: Radius.circular(3),
        ),
      ),
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
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                cardData(title: "Distance", value: "40km"),
                const SizedBox(
                  height: 24,
                  child: VerticalDivider(),
                ),
                cardData(title: "Run time", value: "6hr"),
                const SizedBox(
                  height: 24,
                  child: VerticalDivider(),
                ),
                cardData(title: "KM left", value: "10km")
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget cardData({required String title, required String value}) {
  return Column(
    children: [
      Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
      ),
      Text(value),
    ],
  );
}
