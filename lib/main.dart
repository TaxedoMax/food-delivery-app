import 'package:antons_app/bloc/auth_bloc.dart';
import 'package:antons_app/repository/api_impl/cart_repository_api.dart';
import 'package:antons_app/repository/api_impl/category_repository_api.dart';
import 'package:antons_app/repository/api_impl/products_repository_api.dart';
import 'package:antons_app/repository/api_impl/user_repository_api.dart';
import 'package:antons_app/repository/cart_repository.dart';
import 'package:antons_app/repository/category_repository.dart';
import 'package:antons_app/repository/in_memory_impl/cart_repository_mock.dart';
import 'package:antons_app/repository/in_memory_impl/category_repository_mock.dart';
import 'package:antons_app/repository/in_memory_impl/products_repository_mock.dart';
import 'package:antons_app/repository/in_memory_impl/user_repository_mock.dart';
import 'package:antons_app/repository/products_repository.dart';
import 'package:antons_app/repository/user_repository.dart';
import 'package:antons_app/ui/pages/home_page.dart';
import 'package:antons_app/ui/pages/login_page.dart';
import 'package:antons_app/ui/pages/registration_page.dart';
import 'package:antons_app/use_case/auth_use_case.dart';
import 'package:antons_app/use_case/cart_use_case.dart';
import 'package:antons_app/use_case/category_use_case.dart';
import 'package:antons_app/use_case/product_list_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'bloc/cart_bloc.dart';

void main() {
  // I am going to change service locator (getIt)
  // to dependency injection in future
  getItInit(true);
  runApp(const MyApp());
}

// This bool only while testing, for fast swapping between mocked repositories and real
void getItInit(bool isTest){
  GetIt getIt = GetIt.instance;

  getIt.registerSingleton<CartRepository>(isTest ? CartRepositoryMock() : CartRepositoryApi());
  getIt.registerSingleton<CategoryRepository>(isTest ? CategoryRepositoryMock() : CategoryRepositoryApi());
  getIt.registerSingleton<ProductsRepository>(isTest ? ProductsRepositoryMock() : ProductsRepositoryApi());
  getIt.registerSingleton<UserRepository>(isTest ? UserRepositoryMock() : UserRepositoryApi());

  getIt.registerSingleton(CartUseCase());
  getIt.registerSingleton(CategoryUseCase());
  getIt.registerSingleton(ProductListUseCase());
  getIt.registerSingleton(AuthUseCase());
}

final GoRouter _router = GoRouter(
  initialLocation: '/market',
  routes: [
    GoRoute(path: '/market', builder: (context, state) => const HomePage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/register', builder: (context, state) => const RegistrationPage())
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc()..add(AuthInitEvent())
          ),
          BlocProvider<CartBloc>(
              create: (context) => CartBloc(BlocProvider.of<AuthBloc>(context).stream)..add(CartInitEvent())
          )
        ],
        child: MaterialApp.router(
          title: 'АнтоноМаксоКат',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
            useMaterial3: true,
          ),
          routerConfig: _router,
        )
    );
  }
}


