import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/helper/app_string.dart';
import 'package:insure_mate/theme/app_color.dart';
import 'package:insure_mate/theme/app_text_style.dart';
import 'package:insure_mate/theme/app_theme.dart';
import 'package:insure_mate/widget/app_button_widget.dart';
import 'package:insure_mate/widget/app_textfield_widget.dart';
import 'package:insure_mate/widget/social_media_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            AppString.loginText,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 25.0, top: 25.0, right: 25.0),
          child: Column(
            children: [
              AppTextField(
                textFieldController: emailController,
                placeholderText: AppString.emailText,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.grey,
                  size: 18,
                ),
                textInputType: TextInputType.emailAddress,
              ),
        
              SizedBox(height: 30),
        
              AppTextField(
                textFieldController: passwordController,
                placeholderText: AppString.passwordText,
                isPasswordField: true,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.grey,
                  size: 18,
                ),
              ),
        
              SizedBox(height: 5),
        
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppString.forgotPasswordText,
                    style: AppTextStyle.titleMedium.apply(fontWeightDelta: 1),
                  ),
                ),
              ),
        
              SizedBox(height: 30),
        
              AppButton(
                buttonName: AppString.loginText,
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
              ),
        
              SizedBox(height: 15),
        
              Text(AppString.orText, style: AppTextStyle.bodyMedium),
        
              SizedBox(height: 15),
        
              SocialMediaButton(socialMediaImage: "assets/images/google.png", socialMediaButtonName: AppString.continueWithGoogleText, onTap: (){
                print("Initiate Google Login");
              }),
        
              SizedBox(height: 30),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppString.notRegisteredYetText, style: AppTextStyle.bodyMedium,),
                  TextButton(onPressed: (){
        
                  }, child: Text(AppString.registerHereText, style: AppTextStyle.titleMedium.apply(fontWeightDelta: 1, color: AppColor.primary)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
