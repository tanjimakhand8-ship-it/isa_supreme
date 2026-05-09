import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF00FF41);  // MARCO Green
  static const Color background = Color(0xFF050505);
  static const Color surface = Color(0xFF0F0F0F);
  static const Color border = Color(0xFF1A1A1A);

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.dark(primary: primary),
    textTheme: GoogleFonts.jetBrainsMonoTextTheme().copyWith(
      bodyMedium: const TextStyle(color: Colors.white70),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black, elevation: 0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: primary,
      unselectedItemColor: Colors.white38,
    ),
  );

  static BoxDecoration glassBubble(bool isUser) {
    return BoxDecoration(
      color: isUser ? primary.withOpacity(0.15) : Colors.white.withOpacity(0.05),
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(18),
        topRight: const Radius.circular(18),
        bottomLeft: Radius.circular(isUser ? 18 : 4),
        bottomRight: Radius.circular(isUser ? 4 : 18),
      ),
      border: Border.all(color: isUser ? primary.withOpacity(0.3) : Colors.white10),
    );
  }
}
