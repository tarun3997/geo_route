import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationUtils {
  static void navigatorPush(BuildContext context, Widget screen) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      Navigator.push(context, CupertinoPageRoute(builder: (context) => screen));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );
    }
  }

  static void navigatorPushAndRemoveUntil(BuildContext context, Widget screen){
    if(Theme.of(context).platform == TargetPlatform.iOS){
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => screen), (route) => false);
    }else{
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> screen), (route) => false);
    }
  }
  static void navigatorPushReplacement(BuildContext context, Widget screen){
    if(Theme.of(context).platform == TargetPlatform.iOS){
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => screen));
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => screen
        ),
      );
    }
  }
}
