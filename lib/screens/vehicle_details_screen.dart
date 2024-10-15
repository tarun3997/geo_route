import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/model/vehicle_details_model.dart';
import 'package:geo_route/provider/vehicle_repair_provider.dart';
import 'package:geo_route/server/api/vehicle_api.dart';
import 'package:geo_route/server/services/mapmyindia_config.dart';
import 'package:geo_route/utils/error_handler.dart';
import 'package:geo_route/utils/gap.dart';
import 'package:geo_route/widget/custom_bottom_sheet.dart';
import 'package:geo_route/widget/custom_button.dart';
import 'package:geo_route/widget/custom_linear_progress_indicator.dart';
import 'package:geo_route/widget/vehicle_fuel_info_card.dart';
import 'package:geo_route/widget/vehicle_imp_info.dart';
import 'package:geo_route/widget/vehicle_info_card.dart';
import 'package:geo_route/widget/vehicle_repairing_info_card.dart';
import 'package:geo_route/widget/vehicle_speed_info_card.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VehicleDetailsScreen extends StatefulWidget {
  final String id;
  final bool isRepairing;
  const VehicleDetailsScreen({super.key, required this.id, required this.isRepairing});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  late MapmyIndiaMapController _mapController;

  final VehicleApi vehicleApi = VehicleApi();
  late Future<VehicleDetailsModel> vehicleDetailsFuture;


  @override
  void initState() {
    MapmyIndiaAccountManager.setMapSDKKey(mapMyIndiaMapSdkKey);
    MapmyIndiaAccountManager.setRestAPIKey(mapMyIndiaRestApiKey);
    MapmyIndiaAccountManager.setAtlasClientId(mapMyIndiaAtlasClientId);
    MapmyIndiaAccountManager.setAtlasClientSecret(mapMyIndiaAtlasClientSecret);
    vehicleDetailsFuture = vehicleApi.getVehicleDetailsById(id: widget.id, role: 'ADMIN');
    super.initState();
  }

  void _onMapCreated(MapmyIndiaMapController controller) async {
    _mapController = controller;
    final vehicleDetails = await vehicleDetailsFuture;
    _mapController.clearSymbols();
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
      ErrorHandler().showError(context, "Getting error to open map. Please try again");
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      vehicleDetailsFuture = vehicleApi.getVehicleDetailsById(id: widget.id,role: 'ADMIN');
    });
    final vehicleDetails = await vehicleDetailsFuture;
    _mapController.clearSymbols();
    _addMarker(lat: vehicleDetails.lat, lng: vehicleDetails.lng);
  }




  @override
  Widget build(BuildContext context) {
    bool isVehicleUnderRepairing = context.watch<VehicleRepairProvider>().isVehicleUnderRepairing;
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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<VehicleRepairProvider>().setVehicleRepairStatus(vehicleDetails.isVehicleUnderRepairing);
            });
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
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vehicleDetails.vehicleNumber ?? "Unknown Vehicle",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                          Row(
                                            children: [
                                              const Icon(CupertinoIcons.person, size: 18,),
                                              Text(vehicleDetails.driverName ?? "Unknown driver"),
                                            ],
                                          ),
                                      Row(
                                        children: [
                                      const Icon(Icons.timer_outlined, size: 16,),
                                      Text(" ${vehicleDetails.updatedTime}", style: const TextStyle(fontSize: 12),)
                                        ],
                                      ),
                                    ],
                                  ),
                            const Divider(
                              thickness: 0.3,
                              color: Colors.black,
                            ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      VehicleImpInfo(vehicleImg: "assets/${vehicleDetails.vehicleType.toString().split('.').last}.png",vehicleName: vehicleDetails.vehicleName ?? "N/A",isActive: vehicleDetails.isActive! ? "Active" : "Active",fuelType: vehicleDetails.vehicleFuelType ?? "N/A", id: vehicleDetails.id ?? "N/A",location: vehicleDetails.currentLocation ?? "N/A",),
                                      const Gap(8),
                                      if(isVehicleUnderRepairing)
                                       VehicleRepairingInfoCard(vehicleDetails: vehicleDetails,onRepairDone: ()=> context.read<VehicleRepairProvider>().setVehicleRepairStatus(false),),
                                      const Gap(12),
                                      CustomLinearProgressIndicator(vehicleNewKm: vehicleDetails.vehicleNewKm,vehicleKMLimit: "${vehicleDetails.vehicleKMLimit}",),

                                      const Gap(12),
                                      VehicleInfoCard(vehicleRunKM: vehicleDetails.vehicleRunKM ?? "N/A",vehicleLimitLeft: vehicleDetails.vehicleLimitLeft ?? "N/A",vehicleKMLimit: "${vehicleDetails.vehicleKMLimit}",refreshData: _refreshData,vehicleId: vehicleDetails.id!,),
                                      const Gap(12),
                                      VehicleSpeedInfoCard(vehicleDetails: vehicleDetails),
                                      const Gap(12),
                                      VehicleFuelInfoCard(vehicleDetails: vehicleDetails),
                                      const Gap(18),
                                      CustomButton(title: "Give for Repair", onTap: (){
                                      CustomBottomSheet.repairBottomSheet(context: context,id: vehicleDetails.id!);
                                      }),
                                      // widget.isRepairing ? Text("data") : Text("data"),

                                    ],
                                  ),
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


