import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/theme/app_color.dart';

import '../../../../../theme/app_text_style.dart';

enum CommissionStatus { gained, lose, notEarned }

class EstimatedCommissionWidget extends StatefulWidget {
  final String estimatedCommission;
  final String gainOrLossPercentage;
  final CommissionStatus commissionStatus;

  const EstimatedCommissionWidget({
    super.key,
    required this.estimatedCommission,
    required this.gainOrLossPercentage,
    required this.commissionStatus,
  });

  @override
  State<EstimatedCommissionWidget> createState() =>
      _EstimatedCommissionWidgetState();
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

            Text(
              widget.estimatedCommission,
              style: AppTextStyle.displayMedium.apply(
                color:
                    widget.commissionStatus == CommissionStatus.gained
                        ? AppColor.success
                        : AppColor.textPrimary,
              ),
            ),

            SizedBox(height: 14),

            _getLastLine(),

            SizedBox(height: 10, width: double.infinity),
          ],
        ),
      ),
    );
  }

  Widget _getLastLine() {
    switch (widget.commissionStatus) {
      case CommissionStatus.notEarned:
        return Text(
          AppString.youAreYetToStartText,
          style: AppTextStyle.titleMedium,
        );

      default:
        return Row(
          spacing: 8,
          children: [
            Text(
              "${widget.commissionStatus == CommissionStatus.gained ? "+" : "-"}${widget.gainOrLossPercentage}%",
              style: AppTextStyle.titleMedium.apply(
                color: widget.commissionStatus == CommissionStatus.gained ? AppColor.success : AppColor.error,
              ),
            ),
            Text(
              AppString.fromLastMonthText,
              style: AppTextStyle.titleMedium,
            ),
          ],
        );
    }
  }
}
