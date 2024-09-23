import 'package:flutter/material.dart';
import 'theme_constants.dart';

ThemeData getLightTheme() {
  return ThemeData.light().copyWith(
    primaryColor: lightPrimaryColor,
    textTheme: const TextTheme(
      bodyLarge: lightBodyLargeTextStyle,
      bodyMedium: lightBodyMediumTextStyle,
    ),
    iconTheme: lightIconTheme,
  );
}

ThemeData getDarkTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: darkPrimaryColor,
    textTheme: const TextTheme(
      bodyLarge: darkBodyLargeTextStyle,
      bodyMedium: darkBodyMediumTextStyle,
    ),
    iconTheme: darkIconTheme,
  );
}
