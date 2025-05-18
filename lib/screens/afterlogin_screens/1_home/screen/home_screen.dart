import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insure_mate/screens/afterlogin_screens/1_home/service/home_service.dart';
import 'package:insure_mate/widget/app_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final HomeService homeService = HomeService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialiseAllData();

  }

  Future<void> initialiseAllData() async{
    await homeService.getLoggedInUserData();

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Hi, ${homeService.currentUserFirstName}")),
      ),

    );
  }
}