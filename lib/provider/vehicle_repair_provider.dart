import 'package:flutter/cupertino.dart';

class VehicleRepairProvider with ChangeNotifier{
  bool _isVehicleUnderRepairing = false;
  bool get isVehicleUnderRepairing => _isVehicleUnderRepairing;

  void setVehicleRepairStatus(bool status){
    _isVehicleUnderRepairing = status;
    notifyListeners();
  }
}