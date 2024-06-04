import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _display = '0';
  String _result = '';
  String _operator = '';
  String _operand1 = '';
  String _operand2 = '';

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _display = '0';
        _result = '';
        _operator = '';
        _operand1 = '';
        _operand2 = '';
      } else if (buttonText == 'Back') {
        _display = _display.length > 1 ? _display.substring(0, _display.length - 1) : '0';
      } else if (buttonText == '%' || buttonText == '/' || buttonText == 'x' || buttonText == '-' || buttonText == '+') {
        if (_operand1.isEmpty) {
          _operand1 = _display;
          _operator = buttonText;
          _display = '0';
        } else if (_operand2.isEmpty) {
          _operand2 = _display;
          _result = _calculateResult();
          _display = _result;
          _operand1 = _result;
          _operator = buttonText;
          _operand2 = '';
        }
      } else if (buttonText == '=') {
        if (_operand1.isNotEmpty && _operator.isNotEmpty && _display.isNotEmpty) {
          _operand2 = _display;
          _result = _calculateResult();
          _display = _result;
          _operand1 = '';
          _operator = '';
          _operand2 = '';
        }
      } else {
        if (_display == '0') {
          _display = buttonText;
        } else {
          _display += buttonText;
        }
      }
    });
  }

  String _calculateResult() {
    double num1 = double.parse(_operand1);
    double num2 = double.parse(_operand2);
    double result;

    switch (_operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case 'x':
        result = num1 * num2;
        break;
      case '/':
        result = num1 / num2;
        break;
      case '%':
        result = num1 % num2;
        break;
      default:
        result = 0.0;
    }

    return result.toString();
  }

  Widget _buildButton(String text) {
    return InkWell(
      onTap: () => _buttonPressed(text),
      child: Container(
        height: 70,
        width: 70,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 41),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(35),
        ),
      ),
    );
  }

  Widget buildButton(String text) {
    return InkWell(
      onTap: () => _buttonPressed(text),
      child: Container(
        height: 70,
        width: 70,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 21),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(35),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.black,
              child: Center(
                child: Text(
                  _display,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 503,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('C'),
                      _buildButton('%'),
                      buildButton('Back'),
                      _buildButton('/'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('7'),
                      _buildButton('8'),
                      _buildButton('9'),
                      _buildButton('x'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('4'),
                      _buildButton('5'),
                      _buildButton('6'),
                      _buildButton('-'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('1'),
                      _buildButton('2'),
                      _buildButton('3'),
                      _buildButton('+'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('00'),
                      _buildButton('0'),
                      _buildButton('.'),
                      _buildButton('='),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
