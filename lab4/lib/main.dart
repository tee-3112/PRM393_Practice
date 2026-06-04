import 'package:flutter/material.dart';
import 'package:lab4/screens/ex2.dart';
import 'package:lab4/screens/ex3.dart';
import 'package:lab4/screens/ex4.dart';
import 'package:lab4/screens/ex5.dart';
import 'package:lab4/screens/ex1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Ex5(),
    );
  }
}