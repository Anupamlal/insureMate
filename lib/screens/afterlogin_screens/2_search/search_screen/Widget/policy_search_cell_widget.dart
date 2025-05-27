import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/generic_models/policy_model.dart';
import 'package:insure_mate/helper/app_helper.dart';
import 'package:insure_mate/theme/app_color.dart';
import 'package:insure_mate/theme/app_text_style.dart';
import 'package:insure_mate/widget/app_textfield_widget.dart';

class PolicySearchCell extends StatelessWidget {

  final Policy policy;

  const PolicySearchCell({super.key, required this.policy});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Row(
                children: [
                  Text(policy.policyholderName, style: AppTextStyle.titleMediumSemiBold.apply(color: AppColor.textPrimary)),
                  Spacer(),
                  Text("${AppHelper.rupee}${policy.premiumAmount}")
                ],
              ),
              Text("Policy No:    ${policy.policyNo}"),
              Text("Mode:   ${policy.premiumMode.rawValue}"),
              Text("Next Due:   ${policy.getPolicyDueDate()}"),
              Row(
                children: [
                  Text("Due Status:   "),
                  policy.getPolicyDueStatus()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  
}