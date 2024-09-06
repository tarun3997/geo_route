import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/model/vehicle_details_model.dart';
import 'package:geo_route/screens/notification_screen.dart';
import 'package:geo_route/server/api/authentication_api.dart';
import 'package:geo_route/server/api/vehicle_api.dart';
import 'package:geo_route/utils/gap.dart';
import 'package:geo_route/utils/helper.dart';
import 'package:geo_route/utils/navigation_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final TextStyle mainStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16);

  final TextStyle subStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70);
  final TextEditingController _textFieldController = TextEditingController();

  final VehicleApi driverApi = VehicleApi();
  Future<VehicleDetailsModel>? driverDetail;
  final double mileage = 4.5;
  final double avgSpeed = 55;
  @override
  void initState() {
    _initializeDriverDetails();
    super.initState();
  }

  Future<void> _initializeDriverDetails() async {
    Map<String, String?> userDetail = await Helper().getId();
    String id = userDetail['id']!;
    String role = userDetail['role']!;
    setState(() {
      driverDetail = driverApi.getVehicleDetailsById(id: id, role: role);
    });
  }
  String? userInput;


  Future<void> displayUpdateDialog({required String title, required String placeholder}) async{
    showDialog(context: context, builder: (BuildContext context) {
      return Theme.of(context).platform == TargetPlatform.iOS ?
      CupertinoAlertDialog(

        title: Text(title),

        content: Column(
          children: [
            const Gap(10),
            CupertinoTextField(
              onChanged: (value) {
                setState(() {
                  userInput = value;
                });
              },
              keyboardType: TextInputType.number,
              controller: _textFieldController,
              placeholder: placeholder,
              style: const TextStyle(fontSize: 16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black, // Underline color
                    width: 1.0,        // Underline width
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(child: const Text('Cancel'), onPressed: (){
            _textFieldController.clear();
            userInput = null;
            Navigator.of(context).pop();
          },),
          CupertinoDialogAction(child: const Text('Insert'), onPressed: ()async{
            if(userInput != null && userInput!.isNotEmpty){
              _textFieldController.clear();
              userInput = null;
            }
          },)

        ],
      )
          : AlertDialog(

        title: Text(title),
        content: TextField(
          onChanged: (value) {
            setState(() {
              userInput = value;
            });
          },
          controller: _textFieldController,
          keyboardType: TextInputType.number,

          decoration:  InputDecoration(hintText: placeholder),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              _textFieldController.clear();
              userInput = null;
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Insert'),
            onPressed: () async {
              if (userInput != null && userInput!.isNotEmpty) {

                _textFieldController.clear();
                userInput = null;
              }
            },
          ),
        ],
      );
    }
    );
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
          "Geo Route",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {
              NavigationUtils.navigatorPush(context, const NotificationScreen());

            },
            icon: const Icon(Icons.notifications, color: Colors.black),
          ),
          GestureDetector(
            onTap: () {
              if (Theme.of(context).platform == TargetPlatform.iOS) {
                _showCupertinoMenu();
              }
            },
            child: Theme.of(context).platform == TargetPlatform.iOS
                ? const Icon(Icons.person, size: 26)
                : Center(
              child: PopupMenuButton(
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
      body: FutureBuilder<VehicleDetailsModel?>(
        future: driverDetail,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? const CupertinoActivityIndicator(radius: 20)
                  : const CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No data found"));
          }else{
            final data = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 2,
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      color: const Color(0xff363333),
                      width: MediaQuery.sizeOf(context).width,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data.driverName ?? "",
                            style: mainStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Card(
                    elevation: 2,
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      color: const Color(0xff363333),
                      width: MediaQuery.sizeOf(context).width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${data.vehicleType}",style: mainStyle,),
                                    Text("Updated at ${data.updatedTime}",style: subStyle,),
                                  ],
                                ),
                                const SizedBox(width: 20,),
                                Text("${data.vehicleFuelType}",style: mainStyle,),
                              ],
                            ),
                            const SizedBox(height: 16,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text("${mileage}km/l",style: mainStyle,),
                                    Text("Mileage",style: subStyle,),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("${data.averageSpeed}km/h",style: mainStyle,),
                                    Text("Avg. Speed",style: subStyle,),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("40Litre",style: mainStyle,),
                                    Text("Fuel Filled",style: subStyle,),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Card(
                    elevation: 2,
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      color: const Color(0xff363333),
                      width: MediaQuery.sizeOf(context).width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Distance", style: mainStyle,),
                            rowValue(text: "Distance", value: "${data.vehicleRunKM}", postfix: "KM"),
                            rowValue(text: "Run Time", value: "06", postfix: "hrs"),
                            rowValue(text: "Remaining", value: "${data.vehicleLimitLeft}", postfix: "KM"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      color: const Color(0xff363333),
                      width: MediaQuery.sizeOf(context).width,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Vehicle Number", style: mainStyle,),
                            Text(data.vehicleNumber ?? '', style: mainStyle,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          displayUpdateDialog(title: "Fuel Entry", placeholder: "Enter fuel amount (liters)");
        },
        backgroundColor: const Color(0xff363333),
        child: const Icon(Icons.local_gas_station_rounded, color: Colors.white,),
      ),
    );

  }

  Widget rowValue ({required String text, required String value, required String postfix}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: subStyle,),
        Text.rich(
          TextSpan(
            text: value,
            style: mainStyle,
            children: [
              TextSpan(
                text: postfix,
                style: subStyle,
              ),
            ]
          ),
        ),
      ],
    );
  }
}
