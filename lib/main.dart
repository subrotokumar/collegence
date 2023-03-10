import 'package:collegence/pages/home.dart';
import 'package:collegence/pages/splashscreen.dart';
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
      title: 'DAO',
      theme: ThemeData.light(),
      home: const HomeScreen(),
    );
  }
}
