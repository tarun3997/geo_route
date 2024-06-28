import 'package:geo_route/enums/VehicleType.dart';

class VehicleShortDetailModel {
  VehicleType? type;
  String? vehicleNumber;
  double? distance;
  int? runTime;
  int? remainingKm;
  String? currentLocation;
  double? todayKm;

  VehicleShortDetailModel(
      {required this.type,
      required this.vehicleNumber,
      required this.distance,
      required this.runTime,
      required this.currentLocation,
      required this.remainingKm,
      required this.todayKm});
}
