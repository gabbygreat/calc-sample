import 'package:flutter/material.dart';

enum ButtonType {
  numeric,
  operation,
  equal,
  backspace,
  clear,
  percent;
}

class CalculatorModel {
  final String? buttonText;
  final Widget? component;
  final ButtonType buttonType;
  final Function(CalculatorModel) onPressed;

  CalculatorModel({
    this.buttonText,
    this.component,
    required this.buttonType,
    required this.onPressed,
  });
}
