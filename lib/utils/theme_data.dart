import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

String? currentTheme;

List<AppTheme> appThemes = [
  AppTheme(
    id: "light_theme",
    description: "Light Theme",
    data: ThemeData(hintColor: Colors.grey.shade500),
    options: ThemeOptions(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      brightTextColor: Colors.black,
      mediumTextColor: Colors.black87,
      lightTextColor: Colors.grey.shade500,
      scaffoldBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white.withOpacity(0.9),
    ),
  ),
  AppTheme(
    id: "dark_theme",
    description: "Dark Theme",
    data: ThemeData(hintColor: Colors.grey.shade500),
    options: ThemeOptions(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      brightTextColor: Colors.white,
      mediumTextColor: Colors.grey.shade300,
      lightTextColor: Colors.grey.shade400,
      scaffoldBackgroundColor: Colors.black87,
      pageBackgroundColor: const Color(0XFF151515),
    ),
  ),
];

class ThemeOptions implements AppThemeOptions {
  final Brightness statusBarBrightness;
  final Brightness statusBarIconBrightness;
  final Color brightTextColor;
  final Color mediumTextColor;
  final Color lightTextColor;
  final Color scaffoldBackgroundColor;
  final Color pageBackgroundColor;

  ThemeOptions({
    required this.statusBarBrightness,
    required this.statusBarIconBrightness,
    required this.brightTextColor,
    required this.mediumTextColor,
    required this.lightTextColor,
    required this.scaffoldBackgroundColor,
    required this.pageBackgroundColor,
  });
}

extension BuildContextExtension on BuildContext {
  ThemeOptions get theme => ThemeProvider.optionsOf<ThemeOptions>(this);
}
