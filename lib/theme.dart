import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  useMaterial3: true,
  primaryColor: const Color(0xFF31965C),
  primaryColorDark: const Color(0xFF4D4D4D),
  primaryColorLight: const Color(0xFFFFFFFF),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),

  // Updated ColorScheme for better Material 3 integration
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF31965C),
    secondary: Color(0xFF31965C),
    surface: Color(0xFFFFFFFF),
    background: Color(0xFFFFFFFF),
    error: Colors.red,
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    onSurface: Color(0xFF4D4D4D),
    onBackground: Color(0xFF4D4D4D),
    onError: Color(0xFFFFFFFF),
  ),

  // ElevatedButton theme configuration
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF31965C),
      foregroundColor: const Color(0xFFFFFFFF),
      minimumSize: const Size(88, 48), // Standard minimum size
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Rubik',
      ),
    ),
  ),

  // Legacy button theme (kept for backward compatibility)
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF31965C),
    textTheme: ButtonTextTheme.primary,
  ),

  // AppBar theme
  appBarTheme: const AppBarTheme(
    color: Color(0xFF31965C),
    foregroundColor: Color(0xFFFFFFFF),
    elevation: 0,
    centerTitle: true,
  ),

  // Font configuration
  fontFamily: 'Rubik',
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
    bodySmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300),
    // bold styles
    displayLarge: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w600),
    displayMedium: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
    displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
  ),
);
