import 'package:flutter/material.dart';
import 'package:synou/screens/home_screen.dart';
import 'package:synou/themes/theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Synonymous',
      theme: AppTheme.theme,
      home: const HomeScreen(),
    );
  }
}

