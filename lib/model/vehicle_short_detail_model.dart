

import 'package:geo_route/enums/vehicle_type.dart';

class VehicleShortDetailModel {
  String id;
  VehicleType? type;
  String? vehicleNumber;
  int? distance;
  int? runTime;
  int? remainingKm;
  String? currentLocation;
  String? updatedTime;
  double lat;
  double lng;
  int? todayKm;
  bool isActive;
  bool isVehicleUnderRepairing;

  VehicleShortDetailModel(
      {required this.type,
        required this.id,
      required this.vehicleNumber,
        required this.updatedTime,
      required this.distance,
      required this.runTime,
      required this.currentLocation,
      required this.lat,
      required this.lng,
      required this.remainingKm,
        required this.isVehicleUnderRepairing,
        required this.isActive,

      required this.todayKm});

  factory VehicleShortDetailModel.fromJson(Map<String, dynamic> json) {
    // Check if 'vehicleLocation' is a Map or String
    dynamic locationData = json['vehicleLocation'];
    double? lat;
    double? lng;
    String? currentLocation;

    if (locationData is Map<String, dynamic>) {
      lat = locationData['latitude']?.toDouble();
      lng = locationData['longitude']?.toDouble();
      currentLocation = locationData['locationName'];
    } else if (locationData is String) {
      lat = 0.0;
      lng = 0.0;
      currentLocation = locationData;
    }

    return VehicleShortDetailModel(
        id: json['id'],
        type: VehicleType.fromString(json['vehicleType'] as String),
        vehicleNumber: json['vehicleNumber'] as String?,
        distance: json['vehicleRunKM'] as int?,
        runTime: json['runTime'] as int?,
        currentLocation: currentLocation,
        remainingKm: json['vehicleKMLimit'] as int?,
        updatedTime: json['updatedTime'] as String?,
        todayKm: json['todayKm'] as int?,
        lat: lat ?? 0.0,
        lng: lng ?? 0.0,
      isActive: json["isActive"],
      isVehicleUnderRepairing: json["isVehicleUnderRepairing"],
    );
  }

}
