import 'package:flutter/material.dart';
import 'package:geo_route/enums/NetworkStatus.dart';
import 'package:geo_route/screens/AuthScreens/Signup.dart';
import 'package:geo_route/screens/HomeScreen.dart';
import 'package:geo_route/screens/SplashScreen.dart';
import 'package:geo_route/server/services/NetworkServices.dart';
import 'package:geo_route/utils/Helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Geo route',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen()
    );
  }
}