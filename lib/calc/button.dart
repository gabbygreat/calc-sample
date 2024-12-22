import 'package:calculator_app/calc/model.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final CalculatorModel model;
  const CalculatorButton({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color color = const Color.fromARGB(255, 183, 181, 181);
    if (isDarkMode) {
      color = const Color.fromARGB(255, 73, 72, 72);
    }
    if (![ButtonType.numeric].contains(model.buttonType)) {
      color = const Color.fromARGB(255, 129, 125, 125);
    }
    if (model.buttonType == ButtonType.equal) {
      color = const Color.fromARGB(255, 255, 126, 5);
    }
    return GestureDetector(
      onTap: () => model.onPressed(model),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        alignment: Alignment.center,
        child: model.buttonText != null
            ? Text(
                model.buttonText!,
                style: Theme.of(context).textTheme.titleLarge,
              )
            : model.component,
      ),
    );
  }
}
