import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/screens/afterlogin_screens/1_home/home_screen/service/home_service.dart';
import 'package:insure_mate/screens/afterlogin_screens/1_home/home_screen/widget/estimated_commission_widget.dart';
import 'package:insure_mate/screens/afterlogin_screens/1_home/home_screen/widget/month_highlight_widget.dart';
import 'package:insure_mate/screens/afterlogin_screens/1_home/home_screen/widget/premium_due_widget.dart';
import 'package:insure_mate/theme/app_color.dart';
import 'package:insure_mate/widget/app_button_widget.dart';
import 'package:insure_mate/widget/app_person_image_widget.dart';

class HomeScreen extends StatefulWidget {
  final void Function(int) changeTabCallback;

  const HomeScreen({super.key, required this.changeTabCallback});

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
    final dueList = [
      {"name": 'Sunita Sharma', "premium": '₹5,000', "due_date": '21 May'},
      {"name": 'Rajiv Mehta', "premium": '₹2,500', "due_date": '23 May'},
      // Add more entries here
    ];

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: getProfileImage(),
        ),
        title: Center(
          child: Text(
            "${AppString.hiText}, ${homeService.currentUserFirstName}",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          IconButton(
            onPressed: notificationsTap,
            icon: Icon(Icons.notifications, size: 30, color: AppColor.primary),
          ),
        ],
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFFAFAFA),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 14.0,
              top: 24.0,
              right: 14.0,
              bottom: 24.0,
            ),
            child: Column(
              spacing: 15,

              children: [
                MonthHighlightWidget(
                  premiumDueText: "₹85,000",
                  premiumPaidText: "₹35,000",
                  newPoliciesText: "5 ${AppString.addedText}",
                ),

                PremiumDueWidget(
                  arrOfDuePremium: dueList,
                  seeAllPremiumCallback: goToAllDuePremiumsList,
                ),

                EstimatedCommissionWidget(estimatedCommission: "₹35,000", gainOrLossPercentage: "10", commissionStatus: CommissionStatus.gained)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getProfileImage() {
    if (homeService.currentUserImage != null &&
        homeService.currentUserImage!.isNotEmpty) {
      return AppPersonImageWidget(
        currentUserImage: homeService.currentUserImage ?? "",
        profileImageTap: profileImageTap,
      );
    } else {
      return InkWell(
        onTap: profileImageTap,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.shade300,
          child: Icon(Icons.person, color: Colors.white),
        ),
      );
    }
  }

  void profileImageTap() {
    widget.changeTabCallback(2);
  }

  void notificationsTap() {
    print("Go to Notifications");
  }

  void goToAllDuePremiumsList() {}
}
