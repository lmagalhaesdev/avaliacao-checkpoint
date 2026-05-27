// Autor: André Lucas Conceição Magalhães
// GitHub: https://github.com/lmagalhaesdev
// LinkedIn: https://www.linkedin.com/in/alucascmagalhaes/
// Data: 24/05/2026

import 'package:app/src/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const HomePage(),
    );
  }
}
