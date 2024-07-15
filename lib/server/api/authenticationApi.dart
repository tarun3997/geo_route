import 'package:dio/dio.dart';
import 'package:geo_route/screens/HomeScreen.dart';
import 'package:geo_route/server/url.dart';
import 'package:geo_route/utils/ErrorHandler.dart';
import 'package:geo_route/utils/Helper.dart';
import 'package:geo_route/utils/NavigationUtils.dart';

import '../../screens/AuthScreens/SignIn.dart';

class Authentication{
  final Dio dio = Dio();
  Future<void> handelUserRegistration(String? name, String? email, String? password, context) async{
    try{
      final response = await dio.post('$url/api/auth/register', data:{
        "name": name,
        "email": email,
        "password": password
      });
      if(response.statusCode == 201){
        String id = response.data['id'];
        Helper().setId(id);
        NavigationUtils.navigatorPushAndRemoveUntil(context, const HomeScreen());
      }else{
        ErrorHandler.showSnackBar(context, "Getting error in registration");
      }
    }catch(e){
      ErrorHandler.showSnackBar(context, "Getting error in registration $e");
    }
  }
  Future<void> handelUserLogin(String? email, String? password, context) async{
    try{
      final response = await dio.post('$url/api/auth/login', data: {
        "email": email,
        "password": password
      });
      if(response.statusCode == 200){
        String id = response.data['id'];
        Helper().setId(id);
        NavigationUtils.navigatorPushAndRemoveUntil(context, const HomeScreen());
      }else{
        ErrorHandler.showSnackBar(context, "Getting error in login");
      }
    }catch(e){
      ErrorHandler.showSnackBar(context, "Getting error in login $e");
    }
  }

  Future<void> handleUserLogout(context) async{
    Helper().setId('');
    NavigationUtils.navigatorPushAndRemoveUntil(context, const SignInScreen());
  }
}