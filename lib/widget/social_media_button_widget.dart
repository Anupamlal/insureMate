import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/app_string.dart';
import '../theme/app_text_style.dart';

class SocialMediaButton extends StatelessWidget {

  final String socialMediaImage;
  final String socialMediaButtonName;
  final VoidCallback onTap;

  const SocialMediaButton({super.key, required this.socialMediaImage, required this.socialMediaButtonName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          side: BorderSide(
              width: 1.0,
              color: Colors.grey.shade100
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Image.asset(socialMediaImage),
            Text(socialMediaButtonName, style: AppTextStyle.titleMedium.apply(color: Colors.black),),
          ],
        ),
      ),
    );
  }

}