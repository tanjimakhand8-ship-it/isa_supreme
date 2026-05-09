import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF6C63FF);
  static const Color background = Color(0xFF121215);
  static const Color surface = Color(0xFF1E1E22);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      surface: surface,
      background: background,
      onPrimary: Colors.white,
      onSurface: Colors.white70,
    ),
    scaffoldBackgroundColor: background,
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface.withOpacity(0.5),
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(28), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(28), borderSide: const BorderSide(color: primary, width: 1.2)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
  );

  static BoxDecoration glassBubble(bool isUser) {
    return BoxDecoration(
      color: isUser ? primary.withOpacity(0.25) : Colors.white.withOpacity(0.06),
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(20),
        topRight: const Radius.circular(20),
        bottomLeft: Radius.circular(isUser ? 20 : 4),
        bottomRight: Radius.circular(isUser ? 4 : 20),
      ),
      border: Border.all(color: isUser ? primary.withOpacity(0.3) : Colors.white.withOpacity(0.08)),
    );
  }
}
