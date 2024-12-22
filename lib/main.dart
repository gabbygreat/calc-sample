
import 'package:calculator_app/calc/calc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorProject());
}

class CalculatorProject extends StatefulWidget {
  const CalculatorProject({super.key});

  @override
  State<CalculatorProject> createState() => _CalculatorProjectState();
}

class _CalculatorProjectState extends State<CalculatorProject> {
  bool isDarkMode = true;

  void toggleMode() {
    isDarkMode = !isDarkMode;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: CalculatorApp(
        toggleMode: toggleMode,
      ),
    );
  }
}
