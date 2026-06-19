import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors_manager.dart';
import 'app_text_style.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: ColorsManager.primary,
        scaffoldBackgroundColor: ColorsManager.backgroundLight,
        colorScheme: const ColorScheme.light(
          primary: ColorsManager.primary,
          secondary: ColorsManager.secondary,
          surface: ColorsManager.white,
          onSurface: ColorsManager.grey900,
          error: ColorsManager.error,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: ColorsManager.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: ColorsManager.grey900),
          titleTextStyle: AppTextStyle.font18Grey900SemiBold,
        ),
        textTheme: TextTheme(
          displayLarge: AppTextStyle.font32Grey900Bold,
          displayMedium: AppTextStyle.font24Grey900Bold,
          displaySmall: AppTextStyle.font20Grey900Bold,
          headlineMedium: AppTextStyle.font18Grey900SemiBold,
          bodyLarge: AppTextStyle.font16Grey700Regular,
          bodyMedium: AppTextStyle.font14Grey600Regular,
          bodySmall: AppTextStyle.font12Grey500Regular,
          labelLarge: AppTextStyle.font14Grey700Medium,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.primary,
            foregroundColor: ColorsManager.white,
            textStyle: AppTextStyle.font16WhiteSemiBold,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            minimumSize: Size(double.infinity, 56.h),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ColorsManager.white,
          hintStyle: AppTextStyle.font14Grey400Regular,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: ColorsManager.grey200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: ColorsManager.grey200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: ColorsManager.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: ColorsManager.error),
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: ColorsManager.primary,
        scaffoldBackgroundColor: ColorsManager.backgroundDark,
        colorScheme: const ColorScheme.dark(
          primary: ColorsManager.primary,
          secondary: ColorsManager.secondary,
          surface: ColorsManager.grey900,
          onSurface: ColorsManager.white,
          error: ColorsManager.error,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: ColorsManager.grey900,
          elevation: 0,
          iconTheme: const IconThemeData(color: ColorsManager.white),
          titleTextStyle: AppTextStyle.font18WhiteSemiBold,
        ),
        textTheme: TextTheme(
          displayLarge: AppTextStyle.font32WhiteBold,
          displayMedium: AppTextStyle.font24WhiteBold,
          displaySmall: AppTextStyle.font20WhiteBold,
          headlineMedium: AppTextStyle.font18WhiteSemiBold,
          bodyLarge: AppTextStyle.font16WhiteRegular,
          bodyMedium: AppTextStyle.font14WhiteRegular,
          bodySmall: AppTextStyle.font12Grey500Regular, // Use existing or add white
          labelLarge: AppTextStyle.font14Grey700Medium.copyWith(color: ColorsManager.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.primary,
            foregroundColor: ColorsManager.white,
            textStyle: AppTextStyle.font16WhiteSemiBold,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            minimumSize: Size(double.infinity, 56.h),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ColorsManager.grey800,
          hintStyle: AppTextStyle.font14Grey400Regular,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: ColorsManager.grey700),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: ColorsManager.grey700),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: ColorsManager.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: ColorsManager.error),
          ),
        ),
      );
}

extension AppThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  bool get isDarkMode => theme.brightness == Brightness.dark;
}
