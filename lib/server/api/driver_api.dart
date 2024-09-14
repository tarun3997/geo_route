
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/model/driver_detail_model.dart';
import 'package:geo_route/server/url.dart';
import 'package:geo_route/utils/helper.dart';

class DriverApi{
  final Dio dio = Dio();

  Future<DriverDetailModel> getDriverDetail()async{
    try{
      Map<String, String?>? id = await Helper().getId();
      final response = await dio.get("$url/api/driver/get-detail/$id");
      if(response.statusCode == 200){
        final data = response.data;
        return DriverDetailModel.fromJson(data);
      }else {
        throw Exception('Failed to load vehicle details');
      }
    }catch(error){
      print(error);
      throw Exception("$error");
    }
  }
   Future<void> recordFuelRefill({required double fuelAmount, required double odometerReading, required BuildContext context})async{
    try{
      Map<String, String?>? id = await Helper().getId();
      final response = await dio.post("$url/api/vehicle-fuel-refill",
        data: {
          "id":id,
          "fuelAmount":fuelAmount,
          "odometerReading":odometerReading
        }
      );
      if(response.statusCode == 201){
        Navigator.pop(context);
      }else {
        throw Exception('Failed to load vehicle details');
      }
    }catch(error){
      print(error);
      throw Exception("$error");
    }
  }
}