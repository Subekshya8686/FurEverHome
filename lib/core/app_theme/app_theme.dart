import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    fontFamily: "Montserrat Bold",
    primaryColor: const Color(0xCC96614D),
    scaffoldBackgroundColor: Colors.grey[200],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 18,
          fontFamily: "Montserrat Bold",
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF66AEA6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(15),
      border: const OutlineInputBorder(),
      labelStyle: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFFFCDDC9),
      iconTheme: const IconThemeData(
        color: Color(0xFF96614D),
      ),
      titleTextStyle: const TextStyle(
        color: Color(0xFF66AEA6),
        fontSize: 24,
        fontFamily: "Montserrat Bold",
      ),
      elevation: 4.0,
      shadowColor: Colors.black.withOpacity(0.1),
    ),
  );
}
