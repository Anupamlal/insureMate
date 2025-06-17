import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/generic_models/policy_model.dart';
import 'package:insure_mate/helper/app_helper.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/theme/app_color.dart';
import 'package:insure_mate/theme/app_text_style.dart';

class PolicySearchCell extends StatelessWidget {
  final Policy policy;
  final Function(Policy) onTap;

  const PolicySearchCell({
    super.key,
    required this.policy,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
      child: Card(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => onTap(policy),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Row(
                    children: [
                      Text(
                        policy.policyholderName,
                        style: AppTextStyle.titleMediumSemiBold.apply(
                          color: AppColor.textPrimary,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.chevron_right, color: AppColor.primary),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${AppString.premiumAmountText}:    ",
                        style: AppTextStyle.labelLarge.apply(
                          color: AppColor.textSecondary,
                        ),
                      ),
                      Text(
                        "${AppHelper.rupee}${policy.premiumAmount}",
                        style: AppTextStyle.labelLarge.apply(
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${AppString.policyNumberText}:    ",
                        style: AppTextStyle.labelLarge.apply(
                          color: AppColor.textSecondary,
                        ),
                      ),
                      Text(
                        policy.policyNo,
                        style: AppTextStyle.labelLarge.apply(
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
