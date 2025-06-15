import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/helper/app_helper.dart';
import 'package:insure_mate/helper/app_string.dart';

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
                    spacing: 10,
                    children: [
                      Text("Policy Info", style: AppTextStyle.titleLargeSemiBold),

                      Row(
                        children: [
                          Text(AppString.policyholderNameText),
                          Spacer(),
                          Text(policy.policyholderName)
                        ],
                      ),

                      if (policy.phoneNumber != null && policy.phoneNumber!.isNotEmpty) Row(
                        children: [
                          Text(AppString.phoneNumberText),
                          Spacer(),
                          Text(policy.phoneNumber!)
                        ],
                      ),

                      Row(
                        children: [
                          Text(AppString.policyNumberText),
                          Spacer(),
                          Text(policy.policyNo)
                        ],
                      ),

                      Row(
                        children: [
                          Text("Start Date"),
                          Spacer(),
                          Text(policy.getPolicyStartDate())
                        ],
                      ),

                      Row(
                        children: [
                          Text("Premium Mode"),
                          Spacer(),
                          Text(policy.premiumMode.rawValue)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [

                      Row(
                        children: [
                          Text("Premium Info", style: AppTextStyle.titleLargeSemiBold),
                          Spacer(),
                          policy.getPolicyDueStatus()
                        ],
                      ),

                      Row(
                        children: [
                          Text("Due Date"),
                          Spacer(),
                          Text(policy.getPolicyDueDate())
                        ],
                      ),

                      Row(
                        children: [
                          Text(AppString.premiumAmountText),
                          Spacer(),
                          Text("${AppHelper.rupee}${policy.premiumAmount}")
                        ],
                      ),

                      Row(
                        children: [
                          Text("Terms Due"),
                          Spacer(),
                          Text("${policy.getNoOfMissedTerms()}")
                        ],
                      ),

                      Row(
                        children: [
                          Text("Late fee"),
                          Spacer(),
                          Text("${policy.calculateTotalLateFee()}")
                        ],
                      ),
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
