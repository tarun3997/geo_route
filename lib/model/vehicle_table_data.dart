class VehicleTableData {
  String vehicleNumber;
  int vehicleRunKM;
  int vehicleKMLimit;
  double averageSpeed;
  bool isVehicleUnderRepairing;
  String vehicleDriverName;

  VehicleTableData({
    required this.vehicleNumber,
    required this.vehicleRunKM,
    required this.vehicleKMLimit,
    required this.averageSpeed,
    required this.isVehicleUnderRepairing,
    required this.vehicleDriverName,
  });

  factory VehicleTableData.fromJson(Map<String, dynamic> json) {
    return VehicleTableData(
      vehicleNumber: json['vehicleNumber'],
      vehicleRunKM: json['vehicleRunKM'],
      vehicleKMLimit: json['vehicleKMLimit'],
      averageSpeed: (json['averageSpeed'] is int)
          ? (json['averageSpeed'] as int).toDouble()
          : json['averageSpeed'] as double,
      isVehicleUnderRepairing: json['isVehicleUnderRepairing'],
      vehicleDriverName: json['vehicleDriver']['name'],
    );
  }
}
