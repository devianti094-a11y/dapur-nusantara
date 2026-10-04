import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFE85D04);
  static const Color secondary = Color(0xFFFFBA08);
  static const Color background = Color(0xFFFFF8F2);

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
    ),
    scaffoldBackgroundColor: background,
  );
}