import 'package:flutter/material.dart';

import 'calculator_screen.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pro Calculator',
      theme: ThemeData.dark(),
      home: CalculatorScreen(),
    );
  }
}