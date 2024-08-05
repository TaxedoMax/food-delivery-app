import 'package:antons_app/bloc/auth_bloc.dart';
import 'package:antons_app/ui/pages/home_page.dart';
import 'package:antons_app/ui/pages/login_page.dart';
import 'package:antons_app/ui/pages/registration_page.dart';
import 'package:antons_app/use_case/auth_use_case.dart';
import 'package:antons_app/use_case/cart_use_case.dart';
import 'package:antons_app/use_case/category_use_case.dart';
import 'package:antons_app/use_case/product_lict_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

void main() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton(CartUseCase());
  getIt.registerSingleton(CategoryUseCase());
  getIt.registerSingleton(ProductListUseCase());
  getIt.registerSingleton(AuthUseCase());
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/market',
  routes: [
    GoRoute(path: '/market', builder: (context, state) => const HomePage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/register', builder: (context, state) => const RegistrationPage())
  ],
  redirect: (context, GoRouterState state){
    if(BlocProvider.of<AuthBloc>(context).state is UnauthorizedState && state.fullPath != '/login' && state.fullPath != '/register'){
      debugPrint(state.fullPath);
      return '/login';
    }
    return null;
  }
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
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


