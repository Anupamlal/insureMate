import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/screens/onboarding_screens/login_screen/login_screen.dart';

import '../../../../widget/app_button_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.profileText),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 25,
            children: [
              Text(FirebaseAuth.instance.currentUser?.email != null ? FirebaseAuth.instance.currentUser?.email as String : "No email"),
              AppButton(buttonName: "Logout", onTap: () async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                      (route) => false,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}