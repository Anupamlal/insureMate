import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/theme/app_theme.dart';
import 'package:insure_mate/screens/onboarding_screens/tutorial_screen/tutorial_screen.dart';
import 'package:insure_mate/theme/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => TutorialScreen()
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: AppColor.primary,
        child: Center(
          child: Image.asset("assets/images/splash_icon.png")
        ),
      ),
    );
  }
}
