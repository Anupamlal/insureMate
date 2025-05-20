import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/theme/app_color.dart';

import '../../../../../theme/app_text_style.dart';

class EstimatedCommissionWidget extends StatefulWidget {
  final String estimatedCommission;
  final String gainOrLossPercentage;
  final String isGainedOrLoose;

  const EstimatedCommissionWidget({super.key, required this.estimatedCommission, required this.gainOrLossPercentage, required this.isGainedOrLoose});

  @override
  State<EstimatedCommissionWidget> createState() => _EstimatedCommissionWidgetState();
}

class _EstimatedCommissionWidgetState extends State<EstimatedCommissionWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 14,
          right: 14,
          top: 16,
          bottom: 14,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString.estimatedCommissionText,
              style: AppTextStyle.titleLargeSemiBold,
            ),

            SizedBox(height: 14),
            
            Text("₹35,000", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),

            SizedBox(height: 14),

            Row(
              spacing: 8,
              children: [
                Text("+10%", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF2E7D32))),
                Text(AppString.fromLastMonthText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColor.textPrimary)),
              ],
            ),

            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}