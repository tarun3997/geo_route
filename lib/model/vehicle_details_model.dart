

import '../enums/vehicle_type.dart';

class VehicleDetailsModel {
  String? id;
  String? vehicleNumber;
  String? driverName;
  VehicleType? vehicleType;
  String? vehicleName;
  String? vehicleRunKM;
  String? vehicleFuelType;
  int? vehicleKMLimit;
  int? vehicleLimitLeft;
  double lat;
  double lng;
  String? updatedTime;
  bool? isActive;
  String? currentLocation;
  double averageSpeed;
  double maxSpeed;
  double? lastSpeed;
  int? todayKm;

  VehicleDetailsModel(
      {required this.id,
      required this.vehicleNumber,
      required this.driverName,
      required this.vehicleType,
      required this.vehicleRunKM,
      required this.vehicleFuelType,
      required this.vehicleKMLimit,
      required this.lat,
        required this.lastSpeed,
        required this.vehicleName,
        required this.vehicleLimitLeft,
      required this.lng,
      required this.updatedTime,
      required this.isActive,
        required this.averageSpeed,
        required this.maxSpeed,
      required this.currentLocation,
      required this.todayKm});

  factory VehicleDetailsModel.fromJson(Map<String, dynamic> json) {
    dynamic locationData = json['vehicleLocation'];
    double? lat;
    double? lng;
    String? currentLocation;
    double? lastSpeed;

    if (locationData is Map<String, dynamic>) {
      lat = locationData['latitude']?.toDouble();
      lng = locationData['longitude']?.toDouble();
      currentLocation = locationData['locationName'];
      lastSpeed = (locationData['lastSpeed'] as num).toDouble();
    } else if (locationData is String) {
      lat = 0.0;
      lng = 0.0;
      currentLocation = locationData;
    }
    return VehicleDetailsModel(
        id: json["id"],
        vehicleNumber: json["vehicleNumber"],
        driverName: json["driverName"],
        vehicleType: VehicleType.fromString(json['vehicleType'] as String),
        vehicleLimitLeft: json["vehicleLimitLeft"] as int?,
        vehicleRunKM: json["vehicleRunKM"] ,
        vehicleFuelType: json["vehicleFuelType"],
        vehicleKMLimit: json["vehicleKMLimit"] as int?,
        lat: lat ?? 0.0,
        lng: lng ?? 0.0,
        updatedTime: json["updatedTime"],
        isActive: json["isActive"],
        averageSpeed: (json["averageSpeed"] as num?)?.toDouble() ?? 0.0,
        maxSpeed: (json["maxSpeed"] as num?)?.toDouble() ?? 0.0,
        currentLocation: currentLocation,
        lastSpeed: lastSpeed,
        todayKm: json["todayKm"] as int?,
        vehicleName: json["vehicleType"]);
  }
}

