import 'package:shared_preferences/shared_preferences.dart';

class Helper{
  static const String _id = 'id';
  Future<void> setId(String id) async{
    try{
      final pref = await SharedPreferences.getInstance();
      await pref.setString(_id, id);
    }catch(e){
      print('Failed to set token: $e');
    }
  }

  Future<String?> getId() async{
    try{
      final pref = await SharedPreferences.getInstance();
      return pref.getString(_id);
    }catch(e){
      print('Failed to get token: $e');
      return null;
    }
  }
}