import 'package:calculator_app/calc/button.dart';
import 'package:calculator_app/calc/layout.dart';
import 'package:calculator_app/calc/model.dart';
import 'package:calculator_app/calc/transform.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'screen.dart';

class CalculatorApp extends StatefulWidget {
  final void Function() toggleMode;
  const CalculatorApp({
    super.key,
    required this.toggleMode,
  });

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  late List<List<CalculatorButton>> layout;
  late TextEditingController expController;
  late TextEditingController resultController;
  bool clear = false;

  @override
  void initState() {
    super.initState();
    expController = TextEditingController();
    resultController = TextEditingController();
    layout = [
      [
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: 'AC',
            buttonType: ButtonType.clear,
          ),
        ),
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '%',
            buttonType: ButtonType.percent,
          ),
        ),
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            component: const Icon(Icons.backspace_outlined),
            buttonType: ButtonType.backspace,
          ),
        ),
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '÷',
            buttonType: ButtonType.operation,
          ),
        ),
      ],
      [
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '7',
            buttonType: ButtonType.numeric,
          ),
        ),
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '8',
            buttonType: ButtonType.numeric,
          ),
        ),
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '9',
            buttonType: ButtonType.numeric,
          ),
        ),
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: 'x',
            buttonType: ButtonType.operation,
          ),
        ),
      ],
      [
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '4',
            buttonType: ButtonType.numeric,
          ),
        ),
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '5',
            buttonType: ButtonType.numeric,
          ),
        ),
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '6',
            buttonType: ButtonType.numeric,
          ),
        ),
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '-',
            buttonType: ButtonType.operation,
          ),
        ),
      ],
      [
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '1',
            buttonType: ButtonType.numeric,
          ),
        ),
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '2',
            buttonType: ButtonType.numeric,
          ),
        ),
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '3',
            buttonType: ButtonType.numeric,
          ),
        ),
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '+',
            buttonType: ButtonType.operation,
          ),
        ),
      ],
      [
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '00',
            buttonType: ButtonType.numeric,
          ),
        ),
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '0',
            buttonType: ButtonType.numeric,
          ),
        ),
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '.',
            buttonType: ButtonType.numeric,
          ),
        ),
        CalculatorButton(
          model: CalculatorModel(
            onPressed: _onButtonTap,
            buttonText: '=',
            buttonType: ButtonType.equal,
          ),
        ),
      ],
    ];
  }

  void _onButtonTap(CalculatorModel model) {
    if (clear) {
      expController.clear();
      resultController.clear();
    }
    String display = expController.text;
    clear = false;
    switch (model.buttonType) {
      case ButtonType.backspace:
        if (expController.text.isEmpty) {
          return;
        }
        expController.text = expController.text.substring(
          0,
          expController.text.length - 1,
        );
        break;
      case ButtonType.clear:
        expController.clear();
        resultController.clear();
        break;
      case ButtonType.equal:
        String expression = expController.text;
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('x', '*');
        evaluateExpression(
          press: true,
          expression: expression,
        );
        break;
      case ButtonType.numeric:
      case ButtonType.operation:
      case ButtonType.percent:
        String label = model.buttonText!;
        display += label;
        expController.text = display;
        break;
    }
  }

  void evaluateExpression({bool press = false, String? expression}) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression ?? expController.text);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      resultController.text = eval.toString();
      if (press) {
        clear = true;
      }
    } catch (e) {
      if (press) {
        resultController.text = 'Expression Error';
      } else {
        resultController.text = '';
      }
    }
  }

  @override
  void dispose() {
    expController.dispose();
    resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: widget.toggleMode,
            icon: isDarkMode
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
          )
        ],
      ),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: CalculatorScreen(
                    expcontroller: expController,
                    resultController: resultController,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: layout
                        .map((e) => CalculatorButtonLayout(items: e))
                        .toList(),
                  ),
                ),
              ],
            );
          } else {
            return Row(
              children: [
                Expanded(
                  child: CalculatorScreen(
                    expcontroller: expController,
                    resultController: resultController,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: transformTo5x4(layout)
                        .map((e) => CalculatorButtonLayout(items: e))
                        .toList(),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
