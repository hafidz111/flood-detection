import 'package:flood_detection/style/colors/flood_detection_colors.dart';
import 'package:flutter/material.dart';

class FloodDetectionTheme {
  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      backgroundColor: FloodDetectionColors.primaryDark.color,
      foregroundColor: FloodDetectionColors.textWhite.color,
    );
  }

  static ColorScheme get _lightColorScheme {
    return ColorScheme.light(
      primary: FloodDetectionColors.primaryDark.color,
      onPrimary: FloodDetectionColors.textWhite.color,
      secondary: FloodDetectionColors.secondaryLight.color,
      onSecondary: FloodDetectionColors.textWhite.color,
      surface: Colors.white,
      error: FloodDetectionColors.statusFailed.color,
    );
  }

  static ColorScheme get _darkColorScheme {
    return ColorScheme.dark(
      primary: FloodDetectionColors.secondaryLight.color,
      onPrimary: FloodDetectionColors.textWhite.color,
      secondary: FloodDetectionColors.secondaryLight.color,
      onSecondary: FloodDetectionColors.textWhite.color,
      surface: FloodDetectionColors.backgroundDark.color,
      error: FloodDetectionColors.statusFailed.color,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: _lightColorScheme,
      brightness: Brightness.light,

      textTheme: ThemeData.light().textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme.copyWith(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      scaffoldBackgroundColor: Colors.grey[50],

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: FloodDetectionColors.primaryDark.color,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: _darkColorScheme,
      brightness: Brightness.dark,

      textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: FloodDetectionColors.textWhite.color,
        displayColor: FloodDetectionColors.textWhite.color,
      ),
      useMaterial3: true,
      appBarTheme: _appBarTheme,
      scaffoldBackgroundColor: FloodDetectionColors.backgroundDark.color,

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: FloodDetectionColors.secondaryLight.color,
      ),

      cardTheme: CardThemeData(
        color: FloodDetectionColors.primaryDark.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: FloodDetectionColors.textWhite.color,
          foregroundColor: FloodDetectionColors.primaryDark.color,
        ),
      ),
    );
  }
}
