import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/theme/app_color.dart';
import 'package:insure_mate/theme/app_text_style.dart';

class PremiumHighlightWidget extends StatefulWidget {
  const PremiumHighlightWidget({super.key});

  @override
  State<PremiumHighlightWidget> createState() => _PremiumHighlightWidgetState();
}

class _PremiumHighlightWidgetState extends State<PremiumHighlightWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 16, bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Premium Highlights", style: AppTextStyle.titleLarge),

            SizedBox(height: 16,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PremiumHighlightColumn(
                  iconText: "🗓️",
                  titleText: "Premium Due",
                  countText: "₹85,000",
                  subTitleText: "This Month",
                ),

                PremiumHighlightColumn(
                  iconText: "✅",
                  titleText: "Premiums Paid",
                  countText: "₹35,000",
                  subTitleText: "So Far",
                ),

                PremiumHighlightColumn(
                  iconText: "👤➕",
                  titleText: "New Clients",
                  countText: "5 Added",
                  subTitleText: "This Month",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PremiumHighlightColumn extends StatelessWidget {
  final String iconText;
  final String titleText;
  final String countText;
  final String subTitleText;

  const PremiumHighlightColumn({
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
        Text(titleText),
        Text(countText),
        Text(subTitleText),
      ],
    );
  }
}
