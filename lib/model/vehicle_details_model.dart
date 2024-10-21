
import '../enums/vehicle_type.dart';

class VehicleDetailsModel {
  String? id;
  String? vehicleNumber;
  String? driverName;
  VehicleType? vehicleType;
  String? vehicleName;
  String? vehicleRunKM;
  String vehicleNewKm;
  String? vehicleFuelType;
  int vehicleKMLimit;
  String? vehicleLimitLeft;
  double lat;
  double lng;
  String? updatedTime;
  bool? isActive;
  String? currentLocation;
  double averageSpeed;
  double maxSpeed;
  double? lastSpeed;
  int? todayKm;
  bool isVehicleUnderRepairing;
  String? vehicleReason;
  String? description;
  String? damagePart;
  double? fuelAmount;
  String? refuelDate;
  double? mileage;

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
        required this.vehicleNewKm,
      required this.lng,
      required this.updatedTime,
      required this.isActive,
        required this.averageSpeed,
        required this.maxSpeed,
      required this.currentLocation,
        this.damagePart,
      required  this.isVehicleUnderRepairing,
        this.description,
        this.vehicleReason,
      required this.todayKm,
        required this.fuelAmount,
        required this.refuelDate,
        required this.mileage
      });

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
      vehicleLimitLeft: json["vehicleLimitLeft"],
      vehicleRunKM: json["vehicleRunKM"],
      vehicleFuelType: json["vehicleFuelType"],
      vehicleKMLimit: json["vehicleKMLimit"],
      lat: lat ?? 0.0,
      lng: lng ?? 0.0,
      vehicleNewKm: json["vehicleNewKm"],
      updatedTime: json["updatedTime"],
      isActive: json["isActive"],
      averageSpeed: (json["averageSpeed"] as num?)?.toDouble() ?? 0.0,
      maxSpeed: (json["maxSpeed"] as num?)?.toDouble() ?? 0.0,
      currentLocation: currentLocation,
      lastSpeed: lastSpeed,
      todayKm: (json["todayKm"] is String
          ? int.tryParse(json["todayKm"])
          : json["todayKm"]) as int?,
      vehicleName: json["vehicleType"],
      isVehicleUnderRepairing: json["isVehicleUnderRepairing"],
      vehicleReason: json["vehicleReason"],
      damagePart: json["damagePart"],
      description: json["description"],
      fuelAmount: (json["fuelAmount"] as num?)?.toDouble() ?? 0.0,
      refuelDate: json["refuelDate"],
      mileage: (json["mileage"] as num?)?.toDouble() ?? 0.0,
    );
  }

}

