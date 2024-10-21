import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/utils/error_handler.dart';
import 'package:geo_route/widget/snack_bar.dart';

import '../url.dart';

Future<void> deleteVehicle({required String? id, required BuildContext context}) async{
  try{
    final Dio dio = Dio();
    final reponse = await dio.delete("$url/api/remove-vehicle/$id");
    if(reponse.statusCode == 200){
      showSnackBar(context, Colors.green, "Vehicle successfully deleted");
    }else {
      ErrorHandler().showError(context, "Getting error");
    }
  }catch(e){
    ErrorHandler().showError(context,  "Getting error while deleting");
  }
}