import 'package:flutter/material.dart';
import 'package:geo_route/screens/AuthScreens/Signup.dart';
import 'package:geo_route/screens/HomeScreen.dart';
import 'package:geo_route/utils/Helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String id = '';

  @override
  void initState() {
    checkUserLogin();
    super.initState();
  }

  // This widget is the root of your application.
  void checkUserLogin()async{
    String? userId = await Helper().getId();
    setState(() {
      id = userId ?? '';
    });


  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
        // id.isEmpty ? const SignupScreen() :
      home:  const HomeScreen()
    );
  }
}


