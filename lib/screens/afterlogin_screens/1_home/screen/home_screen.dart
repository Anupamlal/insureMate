import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insure_mate/screens/afterlogin_screens/1_home/service/home_service.dart';
import 'package:insure_mate/theme/app_color.dart';
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

  Future<void> initialiseAllData() async {
    await homeService.getLoggedInUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: InkWell(
              onTap: profileImageTap,
              child: CachedNetworkImage(
                width: 40,
                height: 40,
                imageUrl: homeService.currentUserImage ?? "",
                fadeInDuration: Duration(microseconds: 0),
                fadeOutDuration: Duration(microseconds: 0),
              ),
            ),
          ),
        ),
        title: Center(
          child: Text(
            "Hi, ${homeService.currentUserFirstName}",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          IconButton(
            onPressed: notificationsTap,
            icon: Icon(Icons.notifications, size: 30, color: AppColor.primary,),
          ),
        ],
      ),
    );
  }

  void profileImageTap() {
    print("Go to profile");
  }

  void notificationsTap() {
    print("Go to Notifications");
  }
}
