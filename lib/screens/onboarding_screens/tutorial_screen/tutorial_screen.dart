import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/screens/onboarding_screens/login_screen/login_screen.dart';
import 'package:insure_mate/theme/app_text_style.dart';
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

            Text(AppString.welcomeToText, style: AppTextStyle.titleMedium),
            Text(
              AppString.appName,
              style: AppTextStyle.displayLarge.apply(fontSizeDelta: 4),
            ),

            SizedBox(height: 20),

            Text(
              AppString.onboardingScreenInfoText,
              style: AppTextStyle.bodyLarge,
              textAlign: TextAlign.center,
            ),

            Spacer(),

            Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: AppButton(
                buttonName: AppString.letsGoText,
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => LoginScreen()
                  ));
                },
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
