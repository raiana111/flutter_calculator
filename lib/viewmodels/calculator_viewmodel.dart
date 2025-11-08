import 'package:flutter/material.dart';
import '../models/calculator_model.dart';

class CalculatorViewModel extends ChangeNotifier {
  final CalculatorModel _model = CalculatorModel();

  String get input => _model.input;
  String get result => _model.result;

  void onButtonClick(String value) {
    if (value == 'C') {
      _model.input = '';
      _model.result = '';
    } else if (value == '=') {
      try {
        final expression = _model.input.replaceAll('×', '*').replaceAll('÷', '/');
        _model.result = _calculate(expression);
      } catch (_) {
        _model.result = 'Ошибка';
      }
    } else {
      _model.input += value;
    }
    notifyListeners();
  }

  String _calculate(String expression) {
    try {
      final exp = RegExp(r'(\d+\.?\d*|\+|\-|\*|\/)');
      final tokens = exp.allMatches(expression).map((e) => e.group(0)!).toList();

      if (tokens.isEmpty) return '';

      double total = double.parse(tokens[0]);
      for (int i = 1; i < tokens.length; i += 2) {
        final op = tokens[i];
        final num = double.parse(tokens[i + 1]);
        switch (op) {
          case '+':
            total += num;
            break;
          case '-':
            total -= num;
            break;
          case '*':
            total *= num;
            break;
          case '/':
            total /= num;
            break;
        }
      }
      if (total == total.toInt()) return total.toInt().toString();
      return total
          .toStringAsFixed(4)
          .replaceFirst(RegExp(r'0+$'), '')
          .replaceFirst(RegExp(r'\.$'), '');
    } catch (_) {
      return 'Ошибка';
    }
  }
}
