import 'package:flutter/material.dart';
import 'features/auth/presentation/pages/test_api_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YonQuiz',
      theme: ThemeData.dark(),
      home: const TestApiPage(),
    );
  }
}