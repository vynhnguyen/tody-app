import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    useMaterial3: true,
    listTileTheme: const ListTileThemeData(
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)),
    textTheme: GoogleFonts.beVietnamProTextTheme(
      TextTheme(
        displayLarge: const TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.pacifico(
          fontSize: 20,
          fontStyle: FontStyle.italic,
        ),
        headlineLarge: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: const TextStyle(
          fontSize: 16.0,
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
