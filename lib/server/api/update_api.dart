
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geo_route/server/url.dart';
import 'package:geo_route/utils/error_handler.dart';
import 'package:geo_route/widget/snack_bar.dart';

Future<void> updateVehicleKmLimit({required BuildContext context ,required String id, required int newLimit, required VoidCallback refresh}) async{
  try{
    final Dio dio = Dio();
    final response = await dio.post("$url/api/update/vehicle-km-limit",data: {
      "id": id,
      "newLimit": newLimit
    });
    if(response.statusCode == 201){
      if(context.mounted) {
        showSnackBar(context, const Color(0xFF4CAF50), "Limit is updated");
        refresh();
        Navigator.pop(context);
      }
    }
  }catch(e){
    if(context.mounted){
      ErrorHandler().showError(context,  "Getting error while updating Km");
    }
  }
}

Future<void> updateVehicleFuel({required BuildContext context ,required String id, required double newFuelEntered,required double vehicleRunKM, required VoidCallback refresh}) async{
  try{
    final Dio dio = Dio();
    final response = await dio.post("$url/api/update/vehicle-fuel",data: {
      "vehicleId": id,
      "newFuelEntered": newFuelEntered,
      "vehicleRunKM": vehicleRunKM
    });
    if(response.statusCode == 201){
      if(context.mounted) {
        showSnackBar(context, const Color(0xFF4CAF50), "Fuel updated");
        refresh();
        Navigator.pop(context);
      }
    }
  }catch(e){
    if(context.mounted){
      ErrorHandler().showError(context,  "Getting error while updating fuel");
    }
  }
}