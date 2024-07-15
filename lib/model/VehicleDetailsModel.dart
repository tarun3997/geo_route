
import '../enums/VehicleType.dart';

class VehicleDetailsModel {
  String? id;
  String? vehicleNumber;
  String? driverName;
  VehicleType? vehicleType;
  String? vehicleName;
  int? vehicleRunKM;
  String? vehicleFuelType;
  int? vehicleKMLimit;
  double lat;
  double lng;
  String? updatedTime;
  bool? isActive;
  String? currentLocation;
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
        required this.vehicleName,
      required this.lng,
      required this.updatedTime,
      required this.isActive,
      required this.currentLocation,
      required this.todayKm});

  factory VehicleDetailsModel.fromJson(Map<String, dynamic> json) {
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
    return VehicleDetailsModel(
        id: json["id"],
        vehicleNumber: json["vehicleNumber"],
        driverName: json["driverName"],
        vehicleType: VehicleType.fromString(json['vehicleType'] as String),
        vehicleRunKM: json["vehicleRunKM"],
        vehicleFuelType: json["vehicleFuelType"],
        vehicleKMLimit: json["vehicleKMLimit"],
        lat: lat ?? 0.0,
        lng: lng ?? 0.0,
        updatedTime: json["updatedTime"],
        isActive: json["isActive"],
        currentLocation: currentLocation,
        todayKm: json["todayKm"],
        vehicleName: json["vehicleType"]);
  }
}

