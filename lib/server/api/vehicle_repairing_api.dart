import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/model/vehicle_table_data.dart';
import 'package:geo_route/server/url.dart';
import 'package:geo_route/utils/error_handler.dart';

class VehicleRepairingApi {
  final Dio dio = Dio();

  Future<void> addRepairingData({
    required String vehicleId,
    required String vehicleReason,
    required String description,
    required String damagePart,
    required BuildContext context,
  }) async {
    try {
      final response = await dio.post(
        "$url/api/add-repairing",
        data: {
          'vehicleId': vehicleId,
          'vehicleReason': vehicleReason,
          'description': description,
          'damagePart': damagePart,
        },
        options: Options(
          contentType: 'application/json',
        ),
      );
      if (response.statusCode == 200) {
        Navigator.pop(context);
      }
    } catch (e) {
      ErrorHandler().showError(context, "Getting error $e");
    }
  }

  Future<void> handelVehicleRepairDone({required String id, required BuildContext context,required VoidCallback onRepairDone})async{
    try{
      final response = await dio.post("$url/api/repairing-done",data: {
        'id': id
      });
      if(response.statusCode == 200){
        onRepairDone();
      }
    }catch(e){
      print(e);
      ErrorHandler().showError(context, "Getting error $e");
    }
  }
  Future<List<VehicleTableData>> handelVehicleTableData()async{
    try{
      final response = await dio.get("$url/api/vehicle-table");
      if(response.statusCode == 200){
        final List<dynamic> vehicleTable = response.data;
        final List<VehicleTableData> table = vehicleTable.map((tableData) => VehicleTableData.fromJson(tableData)).toList();
        return table;
      }else {
        throw Exception('Failed to load vehicle count');
      }
    }catch(e){
      print(e);
      throw Exception("$e");
    }
  }
}
