import 'package:dio/dio.dart';
import 'package:geo_route/model/VehicleShortDetailModel.dart';
import 'package:geo_route/server/url.dart';
import 'package:geo_route/utils/ErrorHandler.dart';

class VehicleApi{
  final Dio dio = Dio();
  Future<Map<String, dynamic>> handleVehicleCount() async {
    try{
      final response = await dio.get("$url/api/vehicle-count");
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load vehicle count');
      }
    }catch(e){
      throw e;
    }
  }
  
  Future<List<VehicleShortDetailModel>> handleVehicleList()async{
    print("Run code");
    try{
      final response = await dio.get("$url/api/get/vehicle-details");
      if (response.statusCode == 200) {
        print(response.data);
        return response.data;
      } else {
        print("Error");
        throw Exception('Failed to load vehicle count');
      }
    }catch(e){
      print(e);
      throw e;
    }
  }
}