import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insure_mate/widget/app_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
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
              })
            ],
          ),
        ),
      ),
    );
  }
}