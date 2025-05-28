import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PolicyDetailsScreen extends StatelessWidget {
  const PolicyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Policy Details",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
