import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/model/vehicle_details_model.dart';
import 'package:geo_route/model/vehicle_short_detail_model.dart';
import 'package:geo_route/screens/home_screen.dart';
import 'package:geo_route/server/url.dart';
import 'package:geo_route/utils/error_handler.dart';
import 'package:geo_route/utils/navigation_utils.dart';

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
      throw Exception("here $e");
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
      throw Exception("$e");
    }
  }
  
  Future<VehicleDetailsModel> getVehicleDetailsById({required String id, required String role}) async{
    try{
      final response = await dio.get("$url/api/get/vehicle-details-id",options: Options(
        headers: {
          "Authorization": "Bearer your_token_here",
          "Content-Type": "application/json",
          "id":id,
          "role":role
        }
      ));
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
      if (response.statusCode == 201){
        if(context.mounted){
        NavigationUtils.navigatorPushAndRemoveUntil(context, const HomeScreen());
        }
      } else {
        if(context.mounted){
         ErrorHandler().showError(context,  "Getting error in adding vehicle");
        }
      }
    } catch (e) {
      if(context.mounted){
      ErrorHandler().showError(context,  "Getting error $e");
      }
    }
  }
}
