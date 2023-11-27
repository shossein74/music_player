import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'gen/fonts.gen.dart';

final lightThemeData = ThemeData(
  useMaterial3: true,
  textTheme: appTextTheme,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: DefaultThemeColors.primaryColor,
    onPrimary: Colors.white,
    secondary: DefaultThemeColors.secondaryColor,
    onSecondary: Colors.white,
    background: DefaultThemeColors.background,
    onBackground: DefaultThemeColors.primaryTextColor,
    onSurface: DefaultThemeColors.secondaryTextColor,
  ),
);

final darkThemeData = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  textTheme: appTextTheme,
  colorScheme: const ColorScheme.dark(
    primary: DarkThemeColors.primaryColor,
    onPrimary: Colors.white,
    secondary: DarkThemeColors.secondaryColor,
    onSecondary: Colors.white,
    background: DarkThemeColors.background,
    onBackground: DarkThemeColors.primaryTextColor,
    onSurface: DarkThemeColors.secondaryTextColor,
  ),
);

const appTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontFamily: FontFamily.urbanist,
    color: DefaultThemeColors.primaryTextColor,
    fontSize: 96,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  displayMedium: TextStyle(
    fontFamily: FontFamily.urbanist,
    color: DefaultThemeColors.primaryTextColor,
    fontSize: 60,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  displaySmall: TextStyle(
    fontFamily: FontFamily.urbanist,
    color: DefaultThemeColors.primaryTextColor,
    fontSize: 48,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
  ),
  headlineLarge: TextStyle(
    fontFamily: FontFamily.urbanist,
    color: DefaultThemeColors.primaryTextColor,
    fontSize: 34,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headlineMedium: TextStyle(
    fontFamily: FontFamily.urbanist,
    color: DefaultThemeColors.primaryTextColor,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
  ),
  headlineSmall: TextStyle(
    fontFamily: FontFamily.urbanist,
    color: DefaultThemeColors.primaryTextColor,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  bodyLarge: TextStyle(
    fontFamily: FontFamily.urbanist,
    color: DefaultThemeColors.primaryTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  bodyMedium: TextStyle(
    fontFamily: FontFamily.urbanist,
    color: DefaultThemeColors.primaryTextColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  ),
  bodySmall: TextStyle(
    fontFamily: FontFamily.urbanist,
    color: DefaultThemeColors.primaryTextColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  ),
  labelLarge: TextStyle(
    fontFamily: FontFamily.urbanist,
    color: DefaultThemeColors.primaryTextColor,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  ),
  labelMedium: TextStyle(
    fontFamily: FontFamily.urbanist,
    color: DefaultThemeColors.primaryTextColor,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  ),
  labelSmall: TextStyle(
    fontFamily: FontFamily.urbanist,
    color: DefaultThemeColors.primaryTextColor,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.8,
    decoration: TextDecoration.lineThrough,
  ),
);
