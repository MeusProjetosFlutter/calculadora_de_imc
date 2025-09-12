import 'package:calculadora_de_imc/pages/calculator_imc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primaryColor: Colors.green,
        appBarTheme: AppBarTheme(backgroundColor: Colors.green, titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      home: CalculadoraIMC(),
    );
  }
}
