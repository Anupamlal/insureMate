import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AppColor {
  AppColor._(); // Private constructor to prevent instantiation
  static const Color primary = Color(0xFF1D3557);
  static const Color secondary = Color(0xFF457B9D);
  static const Color accent = Color(0xFFF4A261);
  static const Color background = Color(0xFFF8F9FA);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color error = Color(0xFFE63946);
  static const Color success = Color(0xFF2E7D32);

  //Color(0xFF1A237E)

  static const int _primaryValue = 0xFF1D3557;
  static const MaterialColor primarySwatch = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFE3EAF0),
      100: Color(0xFFB9C8DA),
      200: Color(0xFF8CA3C2),
      300: Color(0xFF5F7EA9),
      400: Color(0xFF3E6397),
      500: Color(_primaryValue),
      600: Color(0xFF1A3050),
      700: Color(0xFF162948),
      800: Color(0xFF122240),
      900: Color(0xFF0A1630),
    },
  );
}
