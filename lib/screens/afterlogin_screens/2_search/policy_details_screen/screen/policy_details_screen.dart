import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/helper/app_helper.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/screens/afterlogin_screens/2_search/policy_details_screen/service/policy_detail_service.dart';
import 'package:insure_mate/screens/afterlogin_screens/2_search/policy_details_screen/widget/policy_detail_row.dart';
import 'package:insure_mate/widget/app_button_widget.dart';

import '../../../../../generic_models/policy_model.dart';
import '../../../../../theme/app_color.dart';
import '../../../../../theme/app_text_style.dart';

class PolicyDetailsScreen extends StatelessWidget {
  final Policy policy;
  PolicyDetailsScreen({super.key, required this.policy});

  late PolicyDetailService policyService = PolicyDetailService(policy);

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
                      Text(
                        AppString.policyInfoText,
                        style: AppTextStyle.titleLargeSemiBold,
                      ),

                      PolicyDetailRow(
                        rowName: AppString.policyholderNameText,
                        rowValue: policy.policyholderName,
                      ),

                      if (policy.phoneNumber != null &&
                          policy.phoneNumber!.isNotEmpty)
                        PolicyDetailRow(
                          rowName: AppString.phoneNumberText,
                          rowValue: policy.phoneNumber!,
                        ),

                      PolicyDetailRow(
                        rowName: AppString.policyNumberText,
                        rowValue: policy.policyNo,
                      ),

                      PolicyDetailRow(
                        rowName: AppString.startDateText,
                        rowValue: policy.getPolicyStartDate(),
                      ),

                      PolicyDetailRow(
                        rowName: AppString.premiumModeText,
                        rowValue: policy.premiumMode.rawValue,
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
                          Text(
                            AppString.premiumInfoText,
                            style: AppTextStyle.titleLargeSemiBold,
                          ),
                          Spacer(),
                          policy.getPolicyDueStatus(),
                        ],
                      ),

                      PolicyDetailRow(
                        rowName: AppString.dueDateText,
                        rowValue: policy.getPolicyDueDate(),
                      ),

                      PolicyDetailRow(
                        rowName: AppString.premiumAmountText,
                        rowValue:
                            "${AppHelper.rupee}${policy.premiumAmountValue()}",
                      ),

                      if (policy.currentDueStatusType() != DueStatusType.notDue)
                        getDuePremiumDetails(),
                    ],
                  ),
                ),
              ),
            ),

            if (policy.currentDueStatusType() != DueStatusType.notDue)
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: AppButton(buttonName: AppString.markAsPaidText, onTap: () {}),
              ),
          ],
        ),
      ),
    );
  }

  Widget getDuePremiumDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,

      children: [
        PolicyDetailRow(
          rowName: AppString.termsDueText,
          rowValue: "${policyService.totalTermsDue()}",
        ),

        PolicyDetailRow(
          rowName: AppString.totalDuePremiumText,
          rowValue:
              "${AppHelper.rupee}${policyService.getTotalPremiumAmount()}",
        ),

        PolicyDetailRow(
          rowName: AppString.premiumGSTText,
          rowValue: "${AppHelper.rupee}${policyService.getTotalGSTOnPremium()}",
        ),

        PolicyDetailRow(
          rowName: AppString.lateFeeText,
          rowValue: "${AppHelper.rupee}${policyService.totalLateFee()}",
        ),

        PolicyDetailRow(
          rowName: AppString.lateFeeGSTText,
          rowValue: "${AppHelper.rupee}${policyService.getTotalGSTOnLateFee()}",
        ),

        SizedBox(height: 10),

        Row(
          children: [
            Text(
              policy.currentDueStatusType() == DueStatusType.lapsed
                  ? AppString.totalRevivalAmountText
                  : AppString.totalRenewalAmountText,
              style: AppTextStyle.titleMediumSemiBold,
            ),
            Spacer(),
            Text(
              "${AppHelper.rupee}${policyService.getTotalPaidAmount()}",
              style: AppTextStyle.titleMedium,
            ),
          ],
        ),

        Row(
          children: [
            Text(
              AppString.estimatedCommissionText,
              style: AppTextStyle.titleMediumSemiBold,
            ),
            Spacer(),
            Text(
              "${AppHelper.rupee}${policyService.getExpectedCommission()}",
              style: AppTextStyle.titleMedium,
            ),
          ],
        ),
      ],
    );
  }
}
