import 'package:antons_app/bloc/fragment_bloc.dart';
import 'package:antons_app/ui/pages/home_page.dart';
import 'package:antons_app/use_case/cart_use_case.dart';
import 'package:antons_app/use_case/category_use_case.dart';
import 'package:antons_app/use_case/product_lict_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton(CartUseCase());
  getIt.registerSingleton(CategoryUseCase());
  getIt.registerSingleton(ProductListUseCase());
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
      home: const HomePage(),
    );
  }
}


