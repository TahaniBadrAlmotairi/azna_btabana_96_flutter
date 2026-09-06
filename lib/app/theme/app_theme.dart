import 'package:flutter/material.dart';

class AppColors {
  static const deep = Color(0xFF031D20);
  static const deep2 = Color(0xFF062B2D);
  static const emerald = Color(0xFF079447);
  static const emeraldBright = Color(0xFF18B968);
  static const teal = Color(0xFF0A5553);
  static const white = Color(0xFFF6F7F4);
  static const muted = Color(0xFFB9C8C4);
  static const blue = Color(0xFF0D62C9);
  static const pink = Color(0xFFB21D57);
}

class AppTheme {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.deep,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.emerald,
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.white),
          bodyMedium: TextStyle(color: AppColors.muted),
        ),
      );
}