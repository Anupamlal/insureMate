import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/theme/app_theme.dart';
import 'package:insure_mate/theme/app_color.dart';

class AppButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;

  const AppButton({super.key, required this.buttonName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    // TODO: implement build
    return SizedBox(
      width: screenWidth - 50,
      height: 50,
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            elevation: 4,
          ),
          child: Text(buttonName, style: AppTextTheme.titleMedium.apply(color: Colors.white)),
        ),
    );
  }
}
