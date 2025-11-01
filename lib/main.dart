import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Калькулятор',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String input = '';
  String result = '';

  void onButtonClick(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '';
      } else if (value == '=') {
        try {
          final expression =
              input.replaceAll('×', '*').replaceAll('÷', '/');
          result = _calculate(expression);
        } catch (_) {
          result = 'Ошибка';
        }
      } else {
        input += value;
      }
    });
  }

  String _calculate(String expression) {
    try {
      final exp = RegExp(r'(\d+\.?\d*|\+|\-|\*|\/)');
      final tokens =
          exp.allMatches(expression).map((e) => e.group(0)!).toList();

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
      return total.toStringAsFixed(4).replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
    } catch (_) {
      return 'Ошибка';
    }
  }

  Widget _buildButton(String text,
      {Color? color, double fontSize = 28, double padding = 22}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () => onButtonClick(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[850],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            padding: EdgeInsets.all(padding),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: color != null ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://pbs.twimg.com/media/G1vp23gboAAdgrH.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              alignment: Alignment.centerRight,
              child: Text(
                input,
                style: const TextStyle(
                    fontSize: 40,
                    color: Color.fromARGB(255, 0, 0, 0), 
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: const TextStyle(
                    fontSize: 52,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(color: Colors.white54, thickness: 1),
            Row(
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('÷', color: Colors.orange[300]),
              ],
            ),
            Row(
              children: [
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('×', color: Colors.orange[300]),
              ],
            ),
            Row(
              children: [
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-', color: Colors.orange[300]),
              ],
            ),
            Row(
              children: [
                _buildButton('C', color: Colors.red[300]),
                _buildButton('0'),
                _buildButton('.'),
                _buildButton('+', color: Colors.orange[300]),
              ],
            ),
            Row(
              children: [
                _buildButton('=', color: Colors.green[400], fontSize: 30),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
