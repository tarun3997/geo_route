import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/model/HomeVehicleModel.dart';
import 'package:geo_route/server/api/authenticationApi.dart';
import 'package:geo_route/server/api/vehicleApi.dart';
import 'package:geo_route/utils/ErrorHandler.dart';
import 'package:geo_route/widget/CarCard.dart';
import 'AddVehicle.dart';
import 'VehicleListScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<HomeVehicleModel> homeVehicleModel = [
    HomeVehicleModel(image: 'bike.png', cardTitle: "All vehicles", count: 0),
    HomeVehicleModel(image: 'bike.png', cardTitle: "Two-wheeler", count: 0),
    HomeVehicleModel(image: 'jeep.png', cardTitle: "Four-wheeler", count: 0),
    HomeVehicleModel(image: 'truck.png', cardTitle: "Heavy vehicle", count: 0),
  ];

  final VehicleApi vehicleApi = VehicleApi();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVehicleCount();
  }

  Future<void> fetchVehicleCount() async {
    try {
      final data = await vehicleApi.handleVehicleCount();
      setState(() {
        homeVehicleModel[0].count = data['total'] ?? 0;
        homeVehicleModel[1].count = data['twoWheeler'] ?? 0;
        homeVehicleModel[2].count = data['fourWheeler'] ?? 0;
        homeVehicleModel[3].count = data['heavyVehicle'] ?? 0;
        isLoading = false;
      });
    } catch (e) {
      ErrorHandler.showSnackBar(context, "Getting error in vehicle count $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      isLoading = true;
    });
    await fetchVehicleCount();
  }

  void _showCupertinoMenu() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: const Text('Setting'),
              onPressed: () {},
            ),
            CupertinoActionSheetAction(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.pop(context);
                Authentication().handleUserLogout(context);
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "CMD PATH",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.black),
          ),
          GestureDetector(
            onTap: () {
              if (Theme.of(context).platform == TargetPlatform.iOS) {
                _showCupertinoMenu();
              }
            },
            child: CircleAvatar(
              radius: 18,
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? const Icon(Icons.person, size: 26)
                  : PopupMenuButton(
                icon: const Icon(
                  Icons.person,
                  size: 26,
                ),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                        value: 'setting', child: Text('Setting')),
                    PopupMenuItem(
                        onTap: () {
                          Authentication().handleUserLogout(context);
                        },
                        value: 'logout',
                        child: const Text('Logout')),
                  ];
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        elevation: 1,
        shadowColor: Colors.black,
      ),
      body: isLoading
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (Theme.of(context).platform == TargetPlatform.iOS)
              const CupertinoActivityIndicator(radius: 20)
            else
              const CircularProgressIndicator(),
          ],
        ),
      )
          : _buildRefreshableContent(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          if (Theme.of(context).platform == TargetPlatform.iOS) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const AddVehicleScreen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddVehicleScreen()),
            );
          }
        },
        child: const Icon(Icons.add, size: 36, color: Colors.white),
      ),
    );
  }

  Widget _buildRefreshableContent() {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverRefreshControl(
            onRefresh: _refresh,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Vehicles:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: homeVehicleModel.length,
                        itemBuilder: (context, index) {
                          HomeVehicleModel vehicleModel =
                          homeVehicleModel[index];
                          return GestureDetector(
                            onTap: () {
                              int initialIndex;
                              switch (index) {
                                case 0:
                                  initialIndex = 0;
                                  break;
                                case 1:
                                  initialIndex = 1;
                                  break;
                                case 2:
                                  initialIndex = 0;
                                  break;
                                case 3:
                                  initialIndex = 2;
                                  break;
                                default:
                                  initialIndex = 0;
                                  break;
                              }
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        VehicleListScreen(
                                          initialIndex: initialIndex,
                                        )),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CarCard(
                                image: vehicleModel.image,
                                cardTitle: vehicleModel.cardTitle,
                                count: vehicleModel.count,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Vehicles:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: homeVehicleModel.length,
                  itemBuilder: (context, index) {
                    HomeVehicleModel vehicleModel = homeVehicleModel[index];
                    int initialIndex;
                    switch (index) {
                      case 0:
                        initialIndex = 0;
                        break;
                      case 1:
                        initialIndex = 1;
                        break;
                      case 2:
                        initialIndex = 0;
                        break;
                      case 3:
                        initialIndex = 2;
                        break;
                      default:
                        initialIndex = 0;
                        break;
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VehicleListScreen(
                                initialIndex: initialIndex,
                              )),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CarCard(
                          image: vehicleModel.image,
                          cardTitle: vehicleModel.cardTitle,
                          count: vehicleModel.count,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
