class DriverDetailModel {
  String vehicleNumber;
  String vehicleType;
  int vehicleRunKM;
  String vehicleFuelType;
  int vehicleKMLimit;
  double vehicleNewKm;
  double averageSpeed;
  double maxSpeed;
  String driverName;

  DriverDetailModel(
      {required this.vehicleNumber,
      required this.vehicleType,
      required this.vehicleRunKM,
      required this.vehicleFuelType,
      required this.vehicleKMLimit,
      required this.vehicleNewKm,
      required this.averageSpeed,
      required this.maxSpeed,
      required this.driverName});

  factory DriverDetailModel.fromJson(Map<String, dynamic> json) {
    return DriverDetailModel(
        vehicleNumber: json['vehicleNumber'],
        vehicleType: json['vehicleType'],
        vehicleRunKM: json['vehicleRunKM'],
        vehicleFuelType: json['vehicleFuelType'],
        vehicleKMLimit: json['vehicleKMLimit'],
        vehicleNewKm: json['vehicleNewKm'],
        averageSpeed: (json['averageSpeed'] as num).toDouble(),
        maxSpeed: (json['maxSpeed'] as num).toDouble(),
        driverName: json['vehicleDriver']['name']);
  }
}
