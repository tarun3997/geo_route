import 'package:geo_route/utils/error_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper{
  Future<void> setId(String id, String role) async{
    try{
      final pref = await SharedPreferences.getInstance();
      await pref.setString('id', id);
      await pref.setString('role', role);
    }catch(e){
      print('Failed to set token: $e');
    }
  }

  Future<Map<String, String?>> getId() async{
      final pref = await SharedPreferences.getInstance();
      final String? id = pref.getString('id');
      final String? role = pref.getString('role');
      return {'id': id, 'role': role};
  }

  Future<void> setNotificationToken(String token) async{
      final pref = await SharedPreferences.getInstance();
      await pref.setString('token', token);

  }
  Future<String?> getNotificationToken() async{
    try{
      final pref = await SharedPreferences.getInstance();
      return pref.getString('token');
    }catch(e){
      return null;
    }
  }
}