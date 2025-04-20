import 'package:brill_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColorsLight.mainBackground,
  primaryColor: AppColorsLight.mainHover,
  canvasColor: AppColorsLight.menuBackground,
  dividerColor: AppColorsLight.edgeAndDividers,
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: AppColorsLight.defaultText),
    bodySmall: TextStyle(color: AppColorsLight.secondaryText),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColorsLight.menuBackground,
    foregroundColor: AppColorsLight.defaultText,
    elevation: 0,
  ),
  iconTheme: IconThemeData(color: AppColorsLight.defaultText),
  hoverColor: AppColorsLight.hover,
  highlightColor: AppColorsLight.mainHover,
);
