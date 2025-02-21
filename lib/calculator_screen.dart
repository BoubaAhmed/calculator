import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _expression = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  // Button pressed handler
  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _expression = "";
        num1 = 0;
        num2 = 0;
        operand = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
        num1 = double.parse(_output);
        operand = buttonText;
        _expression = "$num1 $operand ";
        _output = "0";
      } else if (buttonText == ".") {
        if (!_output.contains(".")) {
          _output += ".";
        }
      } else if (buttonText == "=") {
        num2 = double.parse(_output);
        _expression += num2.toString();
        switch (operand) {
          case "+":
            _output = (num1 + num2).toString();
            break;
          case "-":
            _output = (num1 - num2).toString();
            break;
          case "×":
            _output = (num1 * num2).toString();
            break;
          case "÷":
            _output = num2 != 0 ? (num1 / num2).toString() : "Error";
            break;
        }
        _output = _output.endsWith(".0") ? _output.split(".0")[0] : _output;
        _expression = "";
        num1 = 0;
        num2 = 0;
        operand = "";
      } else {
        _output = _output == "0" ? buttonText : _output + buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pro Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(_expression, style: TextStyle(fontSize: 24, color: Colors.grey)),
                  Text(_output, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                ],
              )),
          ),
          _buildButtonGrid(),
        ],
      ),
    );
  }

  Widget _buildButtonGrid() {
    return GridView.count(
      padding: EdgeInsets.all(8),
      shrinkWrap: true,
      crossAxisCount: 4,
      children: [
        _buildButton("C", Colors.redAccent),
        _buildButton("±", Colors.blueGrey),
        _buildButton("%", Colors.blueGrey),
        _buildButton("÷", Colors.amber),
        _buildButton("7", Colors.grey[850]!),
        _buildButton("8", Colors.grey[850]!),
        _buildButton("9", Colors.grey[850]!),
        _buildButton("×", Colors.amber),
        _buildButton("4", Colors.grey[850]!),
        _buildButton("5", Colors.grey[850]!),
        _buildButton("6", Colors.grey[850]!),
        _buildButton("-", Colors.amber),
        _buildButton("1", Colors.grey[850]!),
        _buildButton("2", Colors.grey[850]!),
        _buildButton("3", Colors.grey[850]!),
        _buildButton("+", Colors.amber),
        _buildButton(".", Colors.grey[850]!),
        _buildButton("0", Colors.grey[850]!),
        _buildButton("⌫", Colors.grey[850]!),
        _buildButton("=", Colors.amber),
      ],
    );
  }

  Widget _buildButton(String text, Color color) {
    return Container(
      margin: EdgeInsets.all(6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
        ),
        child: Text(text, style: TextStyle(fontSize: 24)),
        onPressed: () => _buttonPressed(text),
      ),
    );
  }
}