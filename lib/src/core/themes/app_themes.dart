import 'package:flutter/material.dart';

import '../core.dart';

class AppTheme {
  static final String fontFamily = 'Rubik';
  static final ThemeData themeData = ThemeData(
    fontFamily: fontFamily,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.netural.shade900,
    primarySwatch: AppColors.primary,
    primaryTextTheme: Typography().white,
    textTheme: Typography().white,
    cardColor: AppColors.netural.shade700,
    cardTheme: CardTheme(
      color: AppColors.netural.shade700,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      color: AppColors.netural,
      iconTheme: IconThemeData(
        color: AppColors.primary,
      ),
      toolbarTextStyle: TextStyle(
        color: AppColors.white,
        fontFamily: fontFamily,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontFamily: fontFamily,
        fontSize: 18,
      ),
    ),
  );
}

extension ColorConversion on Color {
  MaterialColor toMaterialColor() {
    final List strengths = <double>[.05];
    final Map<int, Color> swatch = {};
    final r = red, g = green, b = blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(value, swatch);
  }
}
