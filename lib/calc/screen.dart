import 'package:flutter/material.dart';

class CalculatorScreen extends StatelessWidget {
  final TextEditingController expcontroller;
  final TextEditingController resultController;
  const CalculatorScreen({
    super.key,
    required this.expcontroller,
    required this.resultController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          textAlign: TextAlign.right,
          controller: expcontroller,
          readOnly: true,
          style: Theme.of(context).textTheme.displayMedium,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
        TextField(
          textAlign: TextAlign.right,
          controller: resultController,
          readOnly: true,
          style: Theme.of(context).textTheme.headlineMedium,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }
}
