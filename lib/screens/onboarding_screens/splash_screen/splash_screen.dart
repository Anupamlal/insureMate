import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/providers/policy_provider/policy_provider.dart';
import 'package:insure_mate/screens/afterlogin_screens/0_bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:insure_mate/screens/afterlogin_screens/1_home/add_policy_screen/service/add_policy_service.dart';
import 'package:insure_mate/screens/onboarding_screens/tutorial_screen/tutorial_screen.dart';
import 'package:insure_mate/theme/app_color.dart';
import 'package:provider/provider.dart';

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

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  FirebaseAuth.instance.currentUser == null
                      ? TutorialScreen()
                      : BottomNavigationScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: AppColor.primary,
        child: Center(
          child: Center(
            child: SizedBox(
              child:
                  Platform.isIOS
                      ? Image.asset("assets/images/splash_icon_ios.png")
                      : Image.asset(
                        "assets/images/splash_icon.png",
                        width: 288,
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
