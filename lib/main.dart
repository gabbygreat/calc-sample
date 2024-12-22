//import 'dart:ui';

//import 'dart:ffi';

//import 'package:calculator_app/service.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

String display = '';
String result = '';

class _CalculatorState extends State<Calculator> {
  void evaluateExpression() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(display);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        result = eval.toString();
        display = result;
      });
    } catch (e) {
      setState(() {
        display = 'error';
      });
    }
  }

  void onButtonPressed(String label) {
    setState(() {
      if (label == 'c' || display == 'error') {
        display = '';
      } else if (label == 'delete') {
        display = display.substring(0, display.length - 1);
      } else if (label == 'x') {
        String multiply = '*';
        display += multiply;
      } else if (label == '%') {
        String percent = ' * 0.01';
        display += percent;
      } else if (label == '=') {
        evaluateExpression();
      } else {
        display += label;
      }
    });
  }

  Widget icondisplay() {
    return IconButton(
      onPressed: () {
        onButtonPressed('delete');
      },
      icon: const Icon(
        Icons.backspace,
        color: Colors.lightBlue,
      ),
    );
  }

  Widget buildNumberButton(String label) {
    return TextButton(
      onPressed: () {
        onButtonPressed(label);
      },
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 45.0),
      ),
    );
  }

  Widget buildSpecialButton(String label) {
    return TextButton(
      onPressed: () {
        onButtonPressed(label);
      },
      child: Text(
        label,
        style: const TextStyle(color: Colors.lightBlue, fontSize: 45.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  display,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 270.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  buildSpecialButton('c'),
                  buildSpecialButton('÷'),
                  buildSpecialButton('x'),
                  icondisplay(),
                  buildNumberButton('7'),
                  buildNumberButton('8'),
                  buildNumberButton('9'),
                  buildSpecialButton('-'),
                  buildNumberButton('4'),
                  buildNumberButton('5'),
                  buildNumberButton('6'),
                  buildSpecialButton('+'),
                  buildNumberButton('1'),
                  buildNumberButton('2'),
                  buildNumberButton('3'),
                  buildSpecialButton('='),
                  buildNumberButton('0'),
                  buildNumberButton('.'),
                  buildNumberButton('0.0'),
                  buildSpecialButton('%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
