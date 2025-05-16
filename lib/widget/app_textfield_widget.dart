import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/theme/app_color.dart';
import 'package:insure_mate/theme/app_text_style.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? textFieldController;
  final String? placeholderText;
  bool isPasswordField = false;
  final Icon? prefixIcon;
  final TextInputType? textInputType;
  
  AppTextField({super.key, this.textFieldController, this.placeholderText, this.isPasswordField = false, this.prefixIcon, this.textInputType});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var screenWidth = MediaQuery.of(context).size.width;
    
    return SizedBox(
      width: screenWidth,
      height: 50,
      child: TextField(
        controller: textFieldController,
        obscureText: isPasswordField,
        cursorColor: AppColor.secondary,
        style: AppTextStyle.bodyMedium,
        keyboardType: textInputType,
        enableInteractiveSelection: !isPasswordField,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: placeholderText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.5
            )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: AppColor.secondary,
                  width: 1.5
              )
          ),
        ),
      ),
    );
  }

}