import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/model/VehicleDetailsModel.dart';
import 'package:geo_route/model/VehicleShortDetailModel.dart';
import 'package:geo_route/screens/HomeScreen.dart';
import 'package:geo_route/server/url.dart';
import 'package:geo_route/utils/ErrorHandler.dart';

class VehicleApi {
  final Dio dio = Dio();
  Future<Map<String, dynamic>> handleVehicleCount() async {
    try {
      final response = await dio.get("$url/api/vehicle-count");
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load vehicle count');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<List<VehicleShortDetailModel>> handleVehicleList() async {
    try {
      final response = await dio.get("$url/api/get/vehicle-details");
      if (response.statusCode == 200) {
        final List<dynamic> vehicleDetails = response.data;
        final List<VehicleShortDetailModel> vehicles = vehicleDetails
            .map((userData) => VehicleShortDetailModel.fromJson(userData as Map<String, dynamic>))
            .toList();
        return vehicles;
      } else {
        throw Exception('Failed to load vehicle count');
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception("$e");
    }
  }
  
  Future<VehicleDetailsModel> getVehicleDetailsById({required String id}) async{
    try{
      print(id);
      final response = await dio.get("$url/api/get/vehicle-details-id/$id");
      if(response.statusCode == 200){
        final data = response.data;
        return VehicleDetailsModel.fromJson(data);
      }else {
        throw Exception('Failed to load vehicle details');
      }
    }catch(e){
      throw Exception("$e");
    }
  }


  Future<void> handleAddVehicleApi(
      {required BuildContext context,
      required String driverName,
      required String id,
      required String vehicleNumber,
      required int vehicleKm,
      required String vehicleType,
      required String fuelType,
      required int setLimit}) async {
    try {
      final response = await dio.post("$url/api/vehicle-detail", data: {
        "id": id,
        "vehicleNumber": vehicleNumber,
        "vehicleType": vehicleType,
        "vehicleRunKM": vehicleKm,
        "vehicleFuelType": fuelType,
        "vehicleKMLimit": setLimit,
        "driverName": driverName
      });
      if (response.statusCode == 201) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
      } else {
        ErrorHandler.showSnackBar(context, "Getting error in adding vehicle");
      }
    } catch (e) {
      ErrorHandler.showSnackBar(context, "Getting error $e");
    }
  }
}
