import 'package:flutter/material.dart';
import 'tip_calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tip Calculator',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Inter'),
      home: TipCalculator(),
    );
  }
}
