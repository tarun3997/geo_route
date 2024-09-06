
import 'package:dio/dio.dart';
import 'package:geo_route/model/notification_model.dart';
import 'package:geo_route/server/url.dart';
import 'package:geo_route/utils/helper.dart';

Future<List<NotificationModel>> handelGetNotification()async{
  final Dio dio = Dio();

  try{
    Map<String, String?> user = await Helper().getId();
    final id = user["id"];
    final role = user["role"];
    Response<dynamic>? response;
    if(role == 'USER'){
      response = await dio.get("$url/api/get-notification/$id");
    }else if(role == 'ADMIN'){
      response = await dio.get("$url/api/admin/get-notification");
    }else{
      throw Exception("Invalid role");
    }
    if(response.statusCode == 200){
      final data = response.data as List<dynamic>;
      return data.map((item) => NotificationModel.fromJson(item)).toList();
    }else{
      throw Exception("Failed to load notification");
    }
  }catch(e){
    print(e);
    throw Exception("$e");
  }
}