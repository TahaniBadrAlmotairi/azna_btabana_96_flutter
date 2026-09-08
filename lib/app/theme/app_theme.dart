import 'package:flutter/material.dart';

class AppColors {
  // الهوية الأساسية
  static const deep = Color(0xFF031D20);
  static const deep2 = Color(0xFF062B2D);
  static const teal = Color(0xFF0A5553);

  // الأخضر
  static const emerald = Color(0xFF079447);
  static const emeraldBright = Color(0xFF18B968);

  // النصوص
  static const white = Color(0xFFF6F7F4);
  static const muted = Color(0xFFB9C8C4);

  // ألوان إضافية للهوية
  static const blue = Color(0xFF0D62C9);
  static const pink = Color(0xFFB21D57);

  // الذهبي للكريستال والزخارف
  static const gold = Color(0xFFD4B56A);
  static const goldLight = Color(0xFFE8D49A);

  // حالات الواجهة
  static const success = Color(0xFF18B968);
  static const error = Color(0xFFD95C5C);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,

      // -----------------------------
      // الخلفية
      // -----------------------------
      scaffoldBackgroundColor: AppColors.deep,

      // -----------------------------
      // الخط الأساسي
      // -----------------------------
      fontFamily: 'SaudiWeb',

      // -----------------------------
      // الألوان
      // -----------------------------
      colorScheme: const ColorScheme.dark(
        primary: AppColors.emerald,
        onPrimary: AppColors.white,
        secondary: AppColors.gold,
        onSecondary: AppColors.deep,
        surface: AppColors.deep2,
        onSurface: AppColors.white,
        error: AppColors.error,
        onError: AppColors.white,
      ),

      // -----------------------------
      // النصوص
      // -----------------------------
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'SaudiWeb',
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontSize: 36,
        ),
        displayMedium: TextStyle(
          fontFamily: 'SaudiWeb',
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontSize: 30,
        ),
        displaySmall: TextStyle(
          fontFamily: 'SaudiWeb',
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontSize: 26,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'SaudiWeb',
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontSize: 28,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'SaudiWeb',
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontSize: 24,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'SaudiWeb',
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontSize: 21,
        ),
        titleLarge: TextStyle(
          fontFamily: 'SaudiWeb',
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontSize: 20,
        ),
        titleMedium: TextStyle(
          fontFamily: 'SaudiWeb',
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontSize: 18,
        ),
        titleSmall: TextStyle(
          fontFamily: 'SaudiWeb',
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontSize: 16,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'SaudiWeb',
          color: AppColors.white,
          fontSize: 17,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'SaudiWeb',
          color: AppColors.muted,
          fontSize: 15,
        ),
        bodySmall: TextStyle(
          fontFamily: 'SaudiWeb',
          color: AppColors.muted,
          fontSize: 13,
        ),
        labelLarge: TextStyle(
          fontFamily: 'SaudiWeb',
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontSize: 16,
        ),
        labelMedium: TextStyle(
          fontFamily: 'SaudiWeb',
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontSize: 14,
        ),
        labelSmall: TextStyle(
          fontFamily: 'SaudiWeb',
          fontWeight: FontWeight.bold,
          color: AppColors.muted,
          fontSize: 12,
        ),
      ),

      // -----------------------------
      // الأزرار الرئيسية
      // -----------------------------
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.emerald,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(
            fontFamily: 'SaudiWeb',
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // -----------------------------
      // الأزرار الثانوية
      // -----------------------------
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.white,
          side: const BorderSide(
            color: AppColors.gold,
            width: 1.3,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 15,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(
            fontFamily: 'SaudiWeb',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // -----------------------------
      // ChoiceChip
      // -----------------------------
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.deep2,
        selectedColor: AppColors.emerald,
        disabledColor: AppColors.deep2,
        secondarySelectedColor: AppColors.emerald,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 9,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(
            color: AppColors.teal,
          ),
        ),
        labelStyle: const TextStyle(
          fontFamily: 'SaudiWeb',
          color: AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: 'SaudiWeb',
          color: AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),

      // -----------------------------
      // حقول الإدخال
      // -----------------------------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.deep2,
        hintStyle: const TextStyle(
          fontFamily: 'SaudiWeb',
          color: AppColors.muted,
        ),
        labelStyle: const TextStyle(
          fontFamily: 'SaudiWeb',
          color: AppColors.muted,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.teal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.gold,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
      ),

      // -----------------------------
      // SnackBar
      // -----------------------------
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.deep2,
        contentTextStyle: const TextStyle(
          fontFamily: 'SaudiWeb',
          color: AppColors.white,
          fontSize: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // -----------------------------
      // Divider
      // -----------------------------
      dividerTheme: const DividerThemeData(
        color: AppColors.teal,
        thickness: 1,
      ),
    );
  }
}
