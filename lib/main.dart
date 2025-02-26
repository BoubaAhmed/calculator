import 'package:flutter/material.dart';

import 'calculator_screen.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pro Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.indigo,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(16),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: isDarkMode ? Colors.black : Colors.indigo,
          foregroundColor: isDarkMode ? Colors.white : Colors.white,
        ),
      ),
      home: CalculatorScreen(
        isDarkMode: isDarkMode,
        onThemeToggle: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}