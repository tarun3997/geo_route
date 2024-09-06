import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geo_route/screens/AuthScreens/sign_in.dart';
import 'package:geo_route/screens/ProfileScreen.dart';
import 'package:geo_route/screens/home_screen.dart';
import 'package:geo_route/utils/gap.dart';
import 'package:geo_route/utils/navigation_utils.dart';

import '../enums/network_status.dart';
import '../server/services/network_services.dart';
import '../utils/helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String id = '';
  late String userRole = '';
  NetworkStatus networkStatus = NetworkStatus.unknown;
  final NetworkServices _networkService = NetworkServices();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _checkNetworkStatus();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  final Helper helper = Helper();

  void _checkNetworkStatus() async {
    NetworkStatus status = await _networkService.checkConnectivity();
    if (!mounted) return;
    setState(() {
      networkStatus = status;
    });
    if (status == NetworkStatus.online) {
      _checkUserLogin();
    } else {
      _timer = Timer(const Duration(seconds: 3), () {
        if (mounted) {
          NavigationUtils.navigatorPushReplacement(context, NoInternetScreen(onRetry: _checkUserLogin, isScaffold: true));
        }
      });
    }
  }

  void _checkUserLogin() async {
    Map<String, String?> user = await helper.getId();
    String? userId = user['id'];
    String? role = user['role'];
    if (userId == null || role == null) {
      if (mounted) {
        NavigationUtils.navigatorPushReplacement(context, const SignInScreen());
      }
      return;
          }
    if (!mounted) return;
    setState(() {
      id = userId;
      userRole = role;
    });
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        if(id.isEmpty && userRole.isEmpty){
        NavigationUtils.navigatorPushReplacement(context, const SignInScreen());
        }else{
          if(role == 'USER'){
            NavigationUtils.navigatorPushReplacement(context, const ProfileScreen());
          }else if(role == 'ADMIN'){
            NavigationUtils.navigatorPushReplacement(context, const HomeScreen());
          }else{
            NavigationUtils.navigatorPushReplacement(context, const SignInScreen());
          }
        }
      }
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Image.asset("assets/logo.png",height: MediaQuery.of(context).size.height,),
      ),
    );
  }
}

class NoInternetScreen extends StatelessWidget {
  final VoidCallback onRetry;
  final bool isScaffold;

  const NoInternetScreen({super.key, required this.onRetry, required this.isScaffold});

  @override
  Widget build(BuildContext context) {
    return isScaffold ? Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Image.asset("assets/no-internet.png"),
          ),
          const Gap(15),
          const Text(
            'Oops, No Internet Connection',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          const Gap(15),
          const Text(
            "It looks like you're offline. Please check your internet connection and try again.",
            textAlign: TextAlign.center,
          ),
          const Gap(15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: (){
              NavigationUtils.navigatorPushReplacement(context, const SplashScreen());
              onRetry();
            },
            child: const Text(
              "Try Again",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    ) : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Image.asset("assets/no-internet.png"),
        ),
        const Gap(15),
        const Text(
          'Oops, No Internet Connection',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        const Gap(15),
        const Text(
          "It looks like you're offline. Please check your internet connection and try again.",
          textAlign: TextAlign.center,
        ),
        const Gap(15),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: (){
            onRetry();
          },
          child: const Text(
            "Try Again",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}