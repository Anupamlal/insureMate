import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/theme/app_color.dart';
import 'package:insure_mate/theme/app_text_style.dart';

class MonthHighlightWidget extends StatefulWidget {
  final String premiumDueText;
  final String premiumPaidText;
  final String newPoliciesText;

  const MonthHighlightWidget({
    super.key,
    required this.premiumDueText,
    required this.premiumPaidText,
    required this.newPoliciesText,
  });

  @override
  State<MonthHighlightWidget> createState() => _MonthHighlightWidgetState();
}

class _MonthHighlightWidgetState extends State<MonthHighlightWidget> {
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
              AppString.monthHighlightsText,
              style: AppTextStyle.titleLargeSemiBold,
            ),

            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PremiumHighlightColumn(
                  iconText: "🗓️",
                  titleText: AppString.premiumDueText,
                  countText: "₹85,000",
                  subTitleText: AppString.thisMonthText,
                ),

                _PremiumHighlightColumn(
                  iconText: "✅",
                  titleText: AppString.premiumPaidText,
                  countText: "₹35,000",
                  subTitleText: AppString.soFarText,
                ),

                _PremiumHighlightColumn(
                  iconText: "👤➕",
                  titleText: AppString.newPoliciesText,
                  countText: "5 Added",
                  subTitleText: AppString.thisMonthText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PremiumHighlightColumn extends StatelessWidget {
  final String iconText;
  final String titleText;
  final String countText;
  final String subTitleText;

  const _PremiumHighlightColumn({
    super.key,
    required this.iconText,
    required this.titleText,
    required this.countText,
    required this.subTitleText,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      spacing: 8,
      children: [
        Text(iconText, style: TextStyle(fontSize: 25)),
        Text(
          titleText,
          style: AppTextStyle.labelLarge.apply(color: AppColor.primary),
        ),
        Text(
          countText,
          style: AppTextStyle.titleMediumSemiBold.apply(color: Colors.black),
        ),
        Text(
          subTitleText,
          style: AppTextStyle.subTitleSmall.apply(
            color: AppColor.textSecondary,
          ),
        ),
      ],
    );
  }
}
