import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculateController extends GetxController {
  RxString equation = ''.obs;
  RxString result = ''.obs;
  final symbols = ['+', '-', '*', '/'];

  void addToEquation(String value) {
    if (symbols.contains(value)) {
      equation.value += ' $value ';
    } else {
      equation.value += value;
    }
  }

  void calculateResult() {
    try {
      final parser = Parser();
      final expression = parser.parse(equation.value);
      final context = ContextModel();
      final eval = expression.evaluate(EvaluationType.REAL, context);
      result.value = eval.toString();
    } catch (e) {
      result.value = 'ERROR';
    }
  }

  void clear() {
    equation.value = '';
    result.value = '';
  }
}
