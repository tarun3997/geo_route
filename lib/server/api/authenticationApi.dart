import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_route/screens/HomeScreen.dart';
import 'package:geo_route/server/url.dart';
import 'package:geo_route/utils/Helper.dart';

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
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const HomeScreen()), (route) => false);
      }else{
        print("Getting error");
      }
    }catch(e){
      print("Getting error in registration");
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
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const HomeScreen()), (route) => false);
      }else{
        print("Getting error");
      }
    }catch(e){
      print("Getting error in login $e");
    }
  }

  Future<void> handelUserLogout(context) async{
    Helper().setId('');
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const SignInScreen()), (route) => false);

  }
}