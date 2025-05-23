import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_color.dart';
import '../theme/app_text_style.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController? textFieldController;
  final String? placeholderText;
  final TextInputType? textInputType;
  final AutovalidateMode? autoValidateMode;
  final int? maxLength;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final bool readOnly;

  const AppTextFormField({
    super.key,
    required this.textFieldController,
    this.placeholderText,
    this.textInputType,
    this.autoValidateMode,
    this.maxLength,
    this.validator,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: textFieldController,
      maxLength: maxLength,
      readOnly: readOnly,
      cursorColor: AppColor.secondary,
      style: AppTextStyle.bodyMedium,
      keyboardType: textInputType,
      textCapitalization: TextCapitalization.words,
      autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
      decoration: InputDecoration(
        labelText: placeholderText,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColor.error, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColor.error, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColor.secondary, width: 1.5),
        ),
      ),
      validator: validator,
      inputFormatters: inputFormatters,
      onTap: onTap,
    );
  }
}
