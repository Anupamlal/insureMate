import 'package:flutter/services.dart';

import 'package:flutter/services.dart';

class NoLeadingZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String newText = newValue.text;

    // Allow empty input
    if (newText.isEmpty) return newValue;

    // If input starts with '0' and length > 1 and second char is NOT '.'
    if (newText.startsWith('0') && newText.length > 1 && newText[1] != '.') {
      // Replace leading zero with the next character(s), e.g. '06' => '6'
      newText = newText.substring(1);
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    // Allow normal input otherwise
    return newValue;
  }
}

