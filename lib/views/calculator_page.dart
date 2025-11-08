import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/calculator_viewmodel.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Consumer<CalculatorViewModel>(
            builder: (context, viewModel, child) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.centerRight,
                child: Text(
                  viewModel.input,
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
          Consumer<CalculatorViewModel>(
            builder: (context, viewModel, child) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.centerRight,
                child: Text(
                  viewModel.result,
                  style: const TextStyle(
                    fontSize: 52,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          const Divider(color: Colors.white54, thickness: 1),
          _buildButtonRow(context, '7', '8', '9', '÷'),
          _buildButtonRow(context, '4', '5', '6', '×'),
          _buildButtonRow(context, '1', '2', '3', '-'),
          _buildButtonRow(context, 'C', '0', '.', '+'),
          Row(
            children: [
              _buildButton(context, '=', color: Colors.green[400], fontSize: 30),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }


  Widget _buildButton(BuildContext context, String text,
      {Color? color, double fontSize = 28, double padding = 22}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () {
            Provider.of<CalculatorViewModel>(context, listen: false)
                .onButtonClick(text);
          },
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


  Row _buildButtonRow(
      BuildContext context, String text1, String text2, String text3, String text4) {
    return Row(
      children: [
        _buildButton(context, text1),
        _buildButton(context, text2),
        _buildButton(context, text3),
        _buildButton(context, text4, color: Colors.orange[300]),
      ],
    );
  }
}
