import 'package:antons_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'themes/main_theme/typography.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'АнтоноМаксоКат',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}


