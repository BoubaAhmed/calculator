import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  CalculatorScreen({required this.isDarkMode, required this.onThemeToggle});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _expression = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _expression = "";
        num1 = 0;
        num2 = 0;
        operand = "";
      } else if (buttonText == "±") {
        // Toggle positive/negative
        if (_output.startsWith("-")) {
          _output = _output.substring(1);
        } else if (_output != "0") {
          _output = "-$_output";
        }
      } else if (buttonText == "%") {
        // Percentage operation
        double value = double.tryParse(_output) ?? 0;
        _output = (value / 100).toString();
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
        num1 = double.tryParse(_output) ?? 0;
        operand = buttonText;
        _expression = "$_output $operand ";
        _output = "0";
      } else if (buttonText == ".") {
        if (!_output.contains(".")) {
          _output += ".";
        }
      } else if (buttonText == "=") {
        num2 = double.tryParse(_output) ?? 0;
        _expression += _output;
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
          default:
            break;
        }
        if (_output != "Error" && _output.contains(".0")) {
          _output = _output.split(".0")[0];
        }
        _expression = "";
        num1 = 0;
        num2 = 0;
        operand = "";
      } else if (buttonText == "⌫") {
        _output = _output.length > 1 ? _output.substring(0, _output.length - 1) : "0";
      } else {
        _output = _output == "0" ? buttonText : _output + buttonText;
      }
    });
  }

  Widget _buildButtonGrid() {
    // Using conditional colors for dark/light mode
    Color baseButtonColor = widget.isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    return GridView.count(
      padding: EdgeInsets.all(8),
      shrinkWrap: true,
      crossAxisCount: 4,
      children: [
        _buildButton("C", Colors.redAccent),
        _buildButton("±", Colors.blueGrey),
        _buildButton("%", Colors.blueGrey),
        _buildButton("÷", Colors.amber),
        _buildButton("7", baseButtonColor),
        _buildButton("8", baseButtonColor),
        _buildButton("9", baseButtonColor),
        _buildButton("×", Colors.amber),
        _buildButton("4", baseButtonColor),
        _buildButton("5", baseButtonColor),
        _buildButton("6", baseButtonColor),
        _buildButton("-", Colors.amber),
        _buildButton("1", baseButtonColor),
        _buildButton("2", baseButtonColor),
        _buildButton("3", baseButtonColor),
        _buildButton("+", Colors.amber),
        _buildButton(".", baseButtonColor),
        _buildButton("0", baseButtonColor),
        _buildButton("⌫", baseButtonColor),
        _buildButton("=", Colors.amber),
      ],
    );
  }

  Widget _buildButton(String text, Color color) {
    return Container(
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.all(1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        child: Text(text, style: TextStyle(fontSize: 20)),
        onPressed: () => _buttonPressed(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pro Calculator'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
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
                  Text(_expression,
                      style: TextStyle(fontSize: 24, color: Colors.grey)),
                  SizedBox(height: 10),
                  Text(
                    _output,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
          _buildButtonGrid(),
        ],
      ),
    );
  }
}