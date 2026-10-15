import 'package:flutter/material.dart';
import 'rosterscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mythic Gold & Obsidian RPG Theme Colors
    const primaryAmber = Color(0xFFEAB308);
    const darkObsidianBg = Color(0xFF090C15);
    const darkCardBg = Color(0xFF111726);

    const lightParchmentBg = Color(0xFFF6F3EC);
    const lightCardBg = Color(0xFFFFFFFF);

    final lightColorScheme = ColorScheme.fromSeed(
      seedColor: primaryAmber,
      brightness: Brightness.light,
      surface: lightParchmentBg,
      primary: const Color(0xFFB45309),
      secondary: const Color(0xFF854D0E),
    );

    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: primaryAmber,
      brightness: Brightness.dark,
      surface: darkObsidianBg,
      primary: primaryAmber,
      secondary: const Color(0xFFF59E0B),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hero Codex • Character Archives',
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: lightParchmentBg,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
          titleMedium: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.3),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xFFEFEAD8),
          foregroundColor: Color(0xFF451A03),
          scrolledUnderElevation: 2,
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          color: lightCardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFE2D9C5), width: 1.5),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        scaffoldBackgroundColor: darkObsidianBg,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
          titleMedium: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.3),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xFF0F1420),
          foregroundColor: Color(0xFFFEF08A),
          scrolledUnderElevation: 4,
        ),
        cardTheme: CardThemeData(
          elevation: 6,
          color: darkCardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: primaryAmber.withOpacity(0.2), width: 1.5),
          ),
        ),
      ),
      home: RosterScreen(
        onToggleTheme: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}
