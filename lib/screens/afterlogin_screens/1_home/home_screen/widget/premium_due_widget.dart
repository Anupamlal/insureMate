import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/helper/app_helper.dart';
import 'package:insure_mate/widget/app_button_widget.dart';

import '../../../../../helper/app_string.dart';
import '../../../../../theme/app_text_style.dart';

class PremiumDueWidget extends StatefulWidget {
  final List<Map<String, String>> arrOfDuePremium;
  final VoidCallback seeAllPremiumCallback;

  const PremiumDueWidget({
    super.key,
    required this.arrOfDuePremium,
    required this.seeAllPremiumCallback,
  });

  @override
  State<PremiumDueWidget> createState() => _PremiumDueWidgetState();
}

class _PremiumDueWidgetState extends State<PremiumDueWidget> {
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
              "${AppString.premiumDueInText} ${AppHelper.monthNames[DateTime.now().month - 1]}",
              style: AppTextStyle.titleLargeSemiBold,
            ),

            SizedBox(height: widget.arrOfDuePremium.isNotEmpty ? 14 : 16),

            ..._getDuePremiumWidget(),

            SizedBox(height: 16),

            widget.arrOfDuePremium.isNotEmpty
                ? AppButton(
                  buttonName: AppString.seeAllDuePremiumsText,
                  onTap: widget.seeAllPremiumCallback,
                )
                : Container(),

            SizedBox(height: 14),
          ],
        ),
      ),
    );
  }

  List<Widget> _getDuePremiumWidget() {
    if (widget.arrOfDuePremium.isNotEmpty) {
      return widget.arrOfDuePremium
          .map<Widget>(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: _buildDueRow(
                item["name"].toString(),
                item["premium"].toString(),
                item["due_date"].toString(),
              ),
            ),
          )
          .toList();
    } else {
      return [
        Align(alignment: Alignment.center, child: const Text(AppString.noPremiumDueText)),
      ];
    }
  }

  Widget _buildDueRow(String name, String amount, String date) {
    return Row(
      children: [
        Expanded(flex: 4, child: Text(name, style: AppTextStyle.bodyMedium)),
        Expanded(
          flex: 2,
          child: Text(
            amount,
            style: AppTextStyle.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            date,
            style: AppTextStyle.bodyMedium.apply(color: Colors.black54),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
