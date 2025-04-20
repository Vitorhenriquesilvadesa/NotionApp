import 'package:brill_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColorsDark.mainBackground,
  primaryColor: AppColorsDark.mainHover,
  canvasColor: AppColorsDark.menuBackground,
  dividerColor: AppColorsDark.edgeAndDividers,
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: AppColorsDark.defaultText),
    bodySmall: TextStyle(color: AppColorsDark.secondaryText),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColorsDark.menuBackground,
    foregroundColor: AppColorsDark.defaultText,
    elevation: 0,
  ),
  iconTheme: IconThemeData(color: AppColorsDark.defaultText),
  hoverColor: AppColorsDark.hover,
  highlightColor: AppColorsDark.mainHover,
);
