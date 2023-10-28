import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  static final ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: const Color(0xFFB82000),
    onPrimary:const Color(0xFFFFFFFF),
    primaryContainer:const Color(0xFFFFDAD3),
    onPrimaryContainer:const Color(0xFF3E0500),
    secondary:const Color(0xFF006397),
    onSecondary:const Color(0xFFFFFFFF),
    secondaryContainer:const Color(0xFFCCE5FF),
    onSecondaryContainer:const Color(0xFF001D31),
    tertiary:const Color(0xFF6B4AB4),
    onTertiary:const Color(0xFFFFFFFF),
    tertiaryContainer:const Color(0xFFEADDFF),
    onTertiaryContainer:const Color(0xFF24005B),
    error:const Color(0xFFC00011),
    onError:const Color(0xFFFFFFFF),
    errorContainer:const Color(0xFFFFDAD6),
    onErrorContainer:const Color(0xFF410002),
    outline:const Color(0xFF7A7768),
    background:const Color(0xFFFAFDFD),
    onBackground:const Color(0xFF191C1D),
    surface:const Color(0xFFF8FAFA),
    onSurface:const Color(0xFF191C1D),
    surfaceVariant:const Color(0xFFE7E3D0),
    onSurfaceVariant:const Color(0xFF49473A),
    inverseSurface:const Color(0xFF2E3132),
    onInverseSurface:const Color(0xFFEFF1F1),
    inversePrimary:const Color(0xFFFFB4A4),
    shadow:const Color(0xFF000000),
    surfaceTint:const Color(0xFFB82000),
    outlineVariant:const Color(0xFFCBC7B5),
    scrim:const Color(0xFF000000),
  );
  static final ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    colorScheme: colorScheme,
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.w400, letterSpacing: -0.25, fontFamily: GoogleFonts.robotoMono().fontFamily ,height: 64.0),
      displayMedium: TextStyle(fontSize: 45.0, fontWeight: FontWeight.w400, letterSpacing: 0.0, fontFamily: GoogleFonts.robotoMono().fontFamily,height: 52.0),
      displaySmall: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w400, letterSpacing: 0.0, fontFamily: GoogleFonts.robotoMono().fontFamily,height: 44.0) ,
      headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400, letterSpacing: 0.0, fontFamily: GoogleFonts.ibmPlexMono().fontFamily,height: 40.0),
      headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w400, letterSpacing: 0.0, fontFamily: GoogleFonts.ibmPlexMono().fontFamily,height: 36.0) ,
      headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400, letterSpacing: 0.0, fontFamily: GoogleFonts.ibmPlexMono().fontFamily,height: 32.0),
      titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400, letterSpacing: 0.0, fontFamily: GoogleFonts.bitter().fontFamily,height: 28.0) ,
      titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, letterSpacing: 0.15, fontFamily: GoogleFonts.bitter().fontFamily,height: 24.0) ,
      titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.1, fontFamily: GoogleFonts.bitter().fontFamily,height: 20.0),
      bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.5, fontFamily: GoogleFonts.rubik().fontFamily,height: 24.0),
      bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, letterSpacing: 0.25, fontFamily: GoogleFonts.rubik().fontFamily,height: 20.0),
      bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, letterSpacing: 0.4, fontFamily: GoogleFonts.rubik().fontFamily,height: 16.0),
      labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, letterSpacing: 0.1, fontFamily: GoogleFonts.lato().fontFamily,height: 20.0),
      labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, letterSpacing: 0.5, fontFamily: GoogleFonts.lato().fontFamily,height: 16.0),
      labelSmall:TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500, letterSpacing: 0.5, fontFamily: GoogleFonts.lato().fontFamily,height: 16.0),
    ),
  );

}