import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/enums/vehicle_type.dart';
import 'package:geo_route/model/vehicle_short_detail_model.dart';
import 'package:geo_route/server/api/vehicle_api.dart';
import 'package:geo_route/widget/vehicle_details_screen_card.dart';

class VehicleListScreen extends StatefulWidget {
  final int initialIndex;

  const VehicleListScreen({super.key, required this.initialIndex});

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final VehicleApi vehicleApi = VehicleApi();
  late Future<List<VehicleShortDetailModel>> vehicleShortDetailModel;
  List<VehicleShortDetailModel> _searchResult = [];
  bool isSearching = false;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this, initialIndex: widget.initialIndex);
    vehicleShortDetailModel = vehicleApi.handleVehicleList();

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  TextEditingController textController = TextEditingController();
  final TextStyle textStyle = const TextStyle(
      fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600);

  void _searchVehicle(String query) async {
    final allVehicles = await vehicleShortDetailModel;
    if (query.isEmpty) {
      setState(() {
        isSearching = false;
        _searchResult.clear();
      });
    } else {
      final filteredResult = allVehicles
          .where((vehicle) =>
          vehicle.vehicleNumber!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        isSearching = true;
        _searchResult = filteredResult;
      });
    }
  }

  void _clearSearch() {
    setState(() {
      textController.clear();
      _searchResult = [];
      isSearching = false;
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      vehicleShortDetailModel = vehicleApi.handleVehicleList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        title: const Text(
          "All Vehicles",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (_searchResult.isNotEmpty || isSearching)
            IconButton(
              onPressed: _clearSearch,
              icon: const Icon(Icons.cancel_outlined),
            )
          else
            AnimSearchBar(
              width: MediaQuery.sizeOf(context).width,
              textController: textController,
              closeSearchOnSuffixTap: false,
              helpText: "Search by vehicle number",
              onSuffixTap: _clearSearch,
              onSubmitted: _searchVehicle,
              color: Colors.transparent,
              boxShadow: false,
            ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          child: Column(
            children: [
              TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 4,
                indicatorColor: Colors.black,
                indicator: const UnderlineTabIndicator(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: 3)),
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 12),
                controller: tabController,
                tabs: [
                  Tab(
                    child: Text(
                      "Car",
                      style: textStyle,
                    ),
                  ),
                  Tab(
                      child: Text(
                        "Bike",
                        style: textStyle,
                      )),
                  Tab(
                      child: Text(
                        "Truck",
                        style: textStyle,
                      )),
                  Tab(
                    child: Text(
                      "Repair",
                      style: textStyle,
                    ),
                  )
                ],
              ),
              FutureBuilder<List<VehicleShortDetailModel>>(
                future: isSearching
                    ? Future.value(_searchResult)
                    : vehicleShortDetailModel,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: Center(
                        child: Theme.of(context).platform == TargetPlatform.iOS
                            ? const CupertinoActivityIndicator(radius: 20)
                            : const CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text('No vehicles available'),
                      ),
                    );
                  } else {
                    final List<VehicleShortDetailModel> data = snapshot.data!;

                    final List<VehicleShortDetailModel> carList = data.where((vehicle) => vehicle.type == VehicleType.car && vehicle.isVehicleUnderRepairing==false).toList();
                    final List<VehicleShortDetailModel> bikeList = data.where((vehicle) => vehicle.type == VehicleType.bike && vehicle.isVehicleUnderRepairing==false).toList();
                    final List<VehicleShortDetailModel> truckList = data.where((vehicle) => vehicle.type == VehicleType.truck && vehicle.isVehicleUnderRepairing==false).toList();
                    final List<VehicleShortDetailModel> repairList = data.where((vehicle) => vehicle.isVehicleUnderRepairing == true).toList();

                    if (isSearching && _searchResult.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No vehicles found',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Flexible(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          _buildVehicleList(
                              carList, textStyle, false),
                          _buildVehicleList(
                              bikeList, textStyle, false),
                          _buildVehicleList(
                              truckList, textStyle, false),
                          _buildVehicleList(
                              repairList, textStyle, true),
                        ],
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleList(List<VehicleShortDetailModel> vehicles,
      TextStyle textStyle, bool isRepairing) {

    if (vehicles.isEmpty) {
      return Center(
        child: Text('No ${isRepairing? 'repairing' : "vehicles"} are available', style: textStyle),
      );
    }
    return Theme.of(context).platform == TargetPlatform.iOS ? _buildCupertinoList(vehicles, isRepairing) : RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
        itemCount: vehicles.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final vehicle = vehicles[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: VehicleDetailsCard(
              id: vehicle.id,
              lng: vehicle.lng,
              lat: vehicle.lat,
              type: vehicle.type,
              currentLocation: vehicle.currentLocation,
              distance: vehicle.distance,
              remainingKm: vehicle.remainingKm,
              runTime: vehicle.runTime ?? 0 ,
              todayKm: vehicle.todayKm ?? 0,
              vehicleNumber: vehicle.vehicleNumber,
              updatedTime: vehicle.updatedTime,
              isActive: vehicle.isActive,
              repairing: vehicle.isVehicleUnderRepairing,

            ),
          );
        },
      ),
    );
  }

  Widget _buildCupertinoList(List vehicles, bool isRepairing){
    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: _refreshData,
        ),
        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index) {
            final vehicle = vehicles[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: VehicleDetailsCard(
                id: vehicle.id,
                lng: vehicle.lng,
                lat: vehicle.lat,
                type: vehicle.type,
                currentLocation: vehicle.currentLocation,
                distance: vehicle.distance,
                remainingKm: vehicle.remainingKm,
                runTime: vehicle.runTime ?? 0 ,
                todayKm: vehicle.todayKm ?? 0,
                vehicleNumber: vehicle.vehicleNumber,
                updatedTime: vehicle.updatedTime,
                isActive: vehicle.isActive,
                repairing: isRepairing,
              ),
            );
          },
          childCount: vehicles.length
        ))
      ],
    );
  }
}