import 'package:flutter/material.dart';

// Light theme constants
const Color lightPrimaryColor = Colors.blueGrey;
const TextStyle lightBodyLargeTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 13,
);
const TextStyle lightBodyMediumTextStyle = TextStyle(
  color: Colors.white,
);
const IconThemeData lightIconTheme = IconThemeData(
  color: Colors.white, // Màu icon chung cho light theme
  size: 30, // Kích thước icon mặc định
);

// Dark theme constants
const Color darkPrimaryColor = Color(0xFF202133);
const TextStyle darkBodyLargeTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 13,
);
const TextStyle darkBodyMediumTextStyle = TextStyle(
  color: Colors.white70,
);
const IconThemeData darkIconTheme = IconThemeData(
  color: Colors.black, // Màu icon chung cho dark theme
  size: 30, // Kích thước icon mặc định
);
