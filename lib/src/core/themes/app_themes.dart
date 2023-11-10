import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/scheduler.dart';

import '../core.dart';

class AppTheme {
  static final String fontFamily = 'Rubik';

  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData.light(useMaterial3: false).copyWith(
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
      ),
      scaffoldBackgroundColor: AppColors.lightScaffoldBackgroundColor,
      cardColor: AppColors.lightCardBackgroundColor,
      cardTheme: CardTheme(
        color: AppColors.lightCardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      primaryTextTheme: Typography().black,
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: fontFamily,
            bodyColor: AppColors.black,
            displayColor: AppColors.black,
          ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightCardBackgroundColor,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: AppColors.lightCardBackgroundColor,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        color: AppColors.lightCardBackgroundColor,
        iconTheme: IconThemeData(
          color: AppColors.secondary,
        ),
        toolbarTextStyle: TextStyle(
          color: AppColors.black,
          fontFamily: fontFamily,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.black,
          fontFamily: fontFamily,
          fontSize: 18,
        ),
      ),
    );
  }

  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData.dark(useMaterial3: false).copyWith(
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
      ),
      scaffoldBackgroundColor: AppColors.darkScaffoldBackgroundColor,
      cardColor: AppColors.darkCardBackgroundColor,
      cardTheme: CardTheme(
        color: AppColors.darkCardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      primaryTextTheme: Typography().white,
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: fontFamily,
            bodyColor: AppColors.white,
            displayColor: AppColors.white,
          ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkCardBackgroundColor,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: AppColors.darkCardBackgroundColor,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0,
        centerTitle: true,
        color: AppColors.darkCardBackgroundColor,
        iconTheme: IconThemeData(
          color: AppColors.secondary,
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

  static ThemeData themeData(BuildContext context) {
    var isDarkMode = Get.isDarkMode;
  // Assuming ThemeService is initialized and available via dependency injection
    ThemeService _themeService = Get.find<ThemeService>();

    // Retrieve the system's theme mode only if there's no theme key stored
    if (!GetStorage().hasData('isDarkMode')) {
      isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    } else {
      isDarkMode = _themeService._loadThemeFromBox(); // Use the existing method to load the stored theme
    }

    return ThemeData(
      fontFamily: fontFamily,
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor:
          isDarkMode ? AppColors.darkScaffoldBackgroundColor : AppColors.lightScaffoldBackgroundColor,
      primarySwatch: AppColors.primary,
      primaryTextTheme: Typography().white,
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: fontFamily,
            bodyColor: isDarkMode ? AppColors.white : AppColors.black,
            displayColor: isDarkMode ? AppColors.white : AppColors.black,
          ),
      cardColor: isDarkMode ? AppColors.darkCardBackgroundColor : AppColors.lightCardBackgroundColor,
      cardTheme: CardTheme(
        color: isDarkMode ? AppColors.darkCardBackgroundColor : AppColors.lightCardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        color: AppColors.lightCardBackgroundColor,
        iconTheme: IconThemeData(
          color: AppColors.primary,
        ),
        toolbarTextStyle: TextStyle(
          color: isDarkMode ? AppColors.white : AppColors.black,
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

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  ThemeMode get systemTheme {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    return brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }

  // This function now uses the system theme as a default if there's no stored key
  ThemeMode get theme {
    if (_box.hasData(_key)) {
      return _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
    } else {
      return systemTheme;
    }
  }

  bool _loadThemeFromBox() => _box.read(_key) ?? false; // No change here
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode); // No change here

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
