import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/theme/app_theme.dart';
import 'package:insure_mate/widget/app_button_widget.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.5,
              width: screenWidth * 0.5,
              child: Image.asset('assets/images/onboarding.png'),
            ),

            Text(AppString.welcomeToText, style: AppTextTheme.titleMedium),
            Text(
              AppString.appName,
              style: AppTextTheme.displayLarge.apply(fontSizeDelta: 4),
            ),

            SizedBox(height: 20),

            Text(
              AppString.onboardingScreenInfoText,
              style: AppTextTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),

            Spacer(),

            AppButton(
              buttonName: AppString.letsGoText,
              onTap: () {
                print("Lets go clicked");
              },
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
