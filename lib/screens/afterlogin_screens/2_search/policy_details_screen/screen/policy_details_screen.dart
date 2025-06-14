import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../generic_models/policy_model.dart';
import '../../../../../theme/app_color.dart';
import '../../../../../theme/app_text_style.dart';

class PolicyDetailsScreen extends StatelessWidget {

  final Policy policy;
  const PolicyDetailsScreen({super.key, required this.policy});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Policy Details",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Policy Info", style: AppTextStyle.titleLargeSemiBold),
                      
                      Row(
                        children: [
                          Text("Policy No"),
                          Spacer(),
                          Text(policy.policyNo)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
