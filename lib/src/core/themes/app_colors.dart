import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

extension CustomColors on ColorScheme {
  Color get lightScaffoldBackgroundColor => Color(0xFFF5F6FA);
  Color get darkScaffoldBackgroundColor => Color(0xFF171F2A);

  Color get lightCardBackgroundColor => Color(0xFFFFFFFF);
  Color get darkCardBackgroundColor => Color(0xFF1E2936);
}

class AppColors {
  static final MaterialColor primary = Color(0xFF5755FF).toMaterialColor();
  static final MaterialColor secondary = Color(0xFFFEB63D).toMaterialColor();

  static final MaterialColor black = Color(0xFF2B2F32).toMaterialColor();
  static final MaterialColor grey = Color(0xFF8091A7).toMaterialColor();
  static final MaterialColor white = Color(0xFFFFFFFF).toMaterialColor();

  static final MaterialColor info = Color(0xFF0052CC).toMaterialColor();
  static final MaterialColor success = Color(0xFF36B37E).toMaterialColor();
  static final MaterialColor warning = Color(0xFFF5C405).toMaterialColor();
  static final MaterialColor danger = Color(0xFFFF5630).toMaterialColor();
  static final MaterialColor cyan = Color(0xFF68F5E3).toMaterialColor();

  static final Color lightScaffoldBackgroundColor = Color(0xFFF5F6FA);
  static final Color darkScaffoldBackgroundColor = Color(0xFF171F2A);

  static final Color lightCardBackgroundColor = Color(0xFFFFFFFF);
  static final Color darkCardBackgroundColor = Color(0xFF1E2936);
}
