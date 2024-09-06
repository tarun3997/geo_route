import 'package:dio/dio.dart';
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
}