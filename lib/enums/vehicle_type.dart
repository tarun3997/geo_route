enum VehicleType{
  bike,
  car,
  truck;

  static VehicleType? fromString(String? value) {
    if (value == null) return null;
    switch (value) {
      case 'Motorcycle':
        return VehicleType.bike;
      case 'Tom25':
        return VehicleType.truck;
      case 'ALS':
        return VehicleType.truck;
      case 'TATRA':
        return VehicleType.truck;
      case 'WB':
        return VehicleType.truck;
      case 'BUS':
        return VehicleType.truck;
      case 'Safari':
        return VehicleType.car;
      case 'Gypsy':
        return VehicleType.car;
      case 'Scorpio':
        return VehicleType.car;
      default:
        return null;
    }
  }
}