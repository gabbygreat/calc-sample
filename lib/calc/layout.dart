import 'package:flutter/material.dart';

import 'button.dart';

class CalculatorButtonLayout extends StatelessWidget {
  final List<CalculatorButton> items;
  const CalculatorButtonLayout({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items.map((e) => Expanded(child: e)).toList(),
    );
  }
}
