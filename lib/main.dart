import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/calculator_page.dart';
import 'viewmodels/calculator_viewmodel.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalculatorViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Калькулятор',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.deepPurple,
        ),
        home: const CalculatorPage(),
      ),
    );
  }
}
