import 'package:dio/dio.dart';
import 'package:geo_route/screens/ProfileScreen.dart';
import 'package:geo_route/screens/home_screen.dart';
import 'package:geo_route/server/url.dart';
import 'package:geo_route/utils/error_handler.dart';
import 'package:geo_route/utils/helper.dart';
import 'package:geo_route/utils/navigation_utils.dart';

import '../../screens/AuthScreens/sign_in.dart';

class Authentication{
  final Dio dio = Dio();
  final Helper helper = Helper();
  Future<void> handelUserRegistration(String? name, String? email, String? password, context) async{
    try{
      final response = await dio.post('$url/api/auth/register', data:{
        "name": name,
        "email": email,
        "password": password,

      });
      if(response.statusCode == 201){
        // String id = response.data['id'];
        NavigationUtils.navigatorPushAndRemoveUntil(context, const HomeScreen());
      }else{
        ErrorHandler().showError(context,"Getting error in registration");
      }
    }catch(e){
      if(e is DioException){
        if(e.response != null){
          String errorMessage = e.response!.data['message'];
          ErrorHandler().showError(context, errorMessage);
        }else {
          ErrorHandler().showError(context,"Getting error in registration");
        }
      }else {
        ErrorHandler().showError(context,"Getting error in registration");
      }
    }
  }
  Future<void> handelUserLogin(String? email, String? password, context) async{
    try{
      String? fcm = await Helper().getNotificationToken();
      final response = await dio.post('$url/api/auth/login', data: {
        "email": email,
        "password": password,
        "fcmToken": fcm
      });
      if(response.statusCode == 200){
        String id = response.data['id'];
        String role = response.data['role'];
        if(role == 'ADMIN'){
          helper.setId(id, "ADMIN");
        NavigationUtils.navigatorPushAndRemoveUntil(context, const HomeScreen());
        }else if(role == 'DRIVER'){
          helper.setId(id, "USER");
        NavigationUtils.navigatorPushAndRemoveUntil(context,  const ProfileScreen());
        }
      }else{
        String errorMessage = response.data['message'];
        ErrorHandler().showError(context, errorMessage);
      }
    }catch(e){
      if(e is DioException){
        if(e.response != null){
          String errorMessage = e.response!.data['message'];
          ErrorHandler().showError(context, errorMessage);
        }else {
           ErrorHandler().showError(context, "Getting error in login");
        }
      }else {
         ErrorHandler().showError(context, "Getting error in login");
      }
    }
  }

  Future<void> handleUserLogout(context) async{
    Helper().setId('','');
    Helper().setNotificationToken('');
    NavigationUtils.navigatorPushAndRemoveUntil(context, const SignInScreen());
  }
}