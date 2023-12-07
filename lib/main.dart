import 'package:flutter/material.dart';
import 'dart:math' as math;
void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayValue = '0';
  double _firstOperand = 0;
  double _secondOperand = 0;
  String _operator = '';
  bool _isOperatorSelected = false;

  void _handleNumberClick(String value) {
    setState(() {
      if (_isOperatorSelected) {
        _displayValue = value;
        _isOperatorSelected = false;
      } else if (_displayValue == '0') {
        _displayValue = value;
      } else {
        _displayValue += value;
      }
    });
  }

  void _handleOperatorClick(String operator) {
    setState(() {
      if (_operator.isNotEmpty && !_isOperatorSelected) {
        _handleEqualsClick();
      }

      _firstOperand = double.parse(_displayValue);
      _operator = operator;
      _isOperatorSelected = true;
    });
  }

  void _handleEqualsClick() {
    setState(() {
      if (_operator.isEmpty || _isOperatorSelected) {
        return;
      }

      _secondOperand = double.parse(_displayValue);
      double? result; // nullable variable

      switch (_operator) {
        case '+':
          result = _firstOperand + _secondOperand;
          break;
        case '-':
          result = _firstOperand - _secondOperand;
          break;
        case '*':
          result = _firstOperand * _secondOperand;
          break;
        case '/':
          if (_secondOperand != 0) {
            result = _firstOperand / _secondOperand;
          } else {
            _displayValue = 'Error';
            return;
          }
          break;
        case '^':
          result = math.pow(_firstOperand!, _secondOperand!).toDouble();

          break;
      }

      _displayValue = result.toString();
      _firstOperand = result ?? 0;
      _secondOperand = 0;
      _operator = '';
      _isOperatorSelected = false;
    });
  }

  void _handleClearClick() {
    setState(() {
      _displayValue = '0';
      _firstOperand = 0;
      _secondOperand = 0;
      _operator = '';
      _isOperatorSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
          children: [
      Expanded(
      child: Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.bottomRight,
      child: Text(
        _displayValue,
        style: TextStyle(fontSize: 36.0),
      ),
    ),
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    _buildNumberButton('7', Colors.white),
    _buildNumberButton('8', Colors.white),
    _buildNumberButton('9', Colors.white),
    _buildOperatorButton('+', Colors.blue),
    ],
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    _buildNumberButton('4', Colors.white),
    _buildNumberButton('5', Colors.white),
    _buildNumberButton('6', Colors.white),
    _buildOperatorButton('-', Colors.blue),
    ],
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    _buildNumberButton('1', Colors.white),
    _buildNumberButton('2', Colors.white),
    _buildNumberButton('3', Colors.white),
    _buildOperatorButton('*', Colors.blue),
    ],
    ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberButton('0', Colors.white),
                _buildClearButton(),
                _buildEqualsButton(),
                _buildOperatorButton('/', Colors.blue),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOperatorButton('^', Colors.blue),
              ],
            ),
          ],
      ),
    );
  }

  Widget _buildNumberButton(String value, Color color) {
    return TextButton(
      onPressed: () {
        _handleNumberClick(value);
      },
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        backgroundColor: MaterialStateProperty.all<Color>(color),
      ),
      child: Text(
        value,
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }

  Widget _buildOperatorButton(String operator, Color color) {
    return TextButton(
      onPressed: () {
        _handleOperatorClick(operator);
      },
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(color),
      ),
      child: Text(
        operator,
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }

  Widget _buildEqualsButton() {
    return TextButton(
      onPressed: () {
        _handleEqualsClick();
      },
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
      ),
      child: Text(
        '=',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }

  Widget _buildClearButton() {
    return TextButton(
      onPressed: () {
        _handleClearClick();
      },
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
      ),
      child: Text(
        'C',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}