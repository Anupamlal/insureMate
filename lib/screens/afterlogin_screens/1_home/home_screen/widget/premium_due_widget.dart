import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/helper/app_helper.dart';

import '../../../../../helper/app_string.dart';
import '../../../../../theme/app_text_style.dart';

class PremiumDueWidget extends StatefulWidget {
  const PremiumDueWidget({super.key});

  @override
  State<PremiumDueWidget> createState() => _PremiumDueWidgetState();
}

class _PremiumDueWidgetState extends State<PremiumDueWidget> {

  var arrOfPolicy = [
    {
      "name": "Shambhavi Kumari",
      "premium": "5000",
      "due_date": "21 May",
    },
    {
      "name": "Anupam Kumar",
      "premium": "6000",
      "due_date": "23 May",
    },
    {
      "name": "Shanu Kumar",
      "premium": "7000",
      "due_date": "31 May",
    }
  ];

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
              "Premium Due in ${AppHelper.monthNames[DateTime.now().month - 1]}",
              style: AppTextStyle.titleLargeSemiBold,
            ),

            SizedBox(height: 16),


          ],
        ),
      ),
    );
  }
}
