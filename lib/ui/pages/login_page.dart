import 'package:antons_app/ui/pages/registration_page.dart';
import 'package:antons_app/ui/themes/main_theme/main_color_scheme.dart';
import 'package:antons_app/ui/themes/main_theme/main_decorations.dart';
import 'package:antons_app/ui/themes/main_theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state){
        if(state is SuccessfulAuthState){
          context.go('/market');
        }
      },
      child: Scaffold(
        backgroundColor: MainColorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          centerTitle: true,
          title: const Text('Вход',
              style: MainTypography.headingTextStyle
          ),
        ),
        body: BlocBuilder<AuthBloc, AuthBlocState>(
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: IntrinsicHeight(
                  child: Container(
                    width: 500,
                    decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.backgroundShadow),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Visibility(
                              visible: state is! UnauthorizedState,
                              child: Column(
                                children: [
                                  const SizedBox(height: 16,),
                                  if(state is LoadingAuthState) const CircularProgressIndicator(),
                                  if(state is ErrorAuthState) Text(state.errorDescription, style: MainTypography.errorTextStyle)
                                ],
                              )
                            ),

                            // Поле для ввода логина
                            TextFormField(
                              controller: _loginController,
                              decoration: const InputDecoration(
                                labelText: 'Логин',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Введите логин';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),

                            // Поле для ввода пароля
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Пароль',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Введите пароль';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 32.0),

                            // Кнопка "Войти"
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() && state is! LoadingAuthState) {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(LoginRequestedEvent(_loginController.text, _passwordController.text));
                                }
                              },
                              child: const Text('Войти'),
                            ),
                            const SizedBox(height: 16.0),

                            // Кнопка "Регистрация"
                            TextButton(
                              onPressed: (){
                                if(state is! LoadingAuthState){
                                  context.go('/register');
                                }
                              },
                              child: const Text('Регистрация'),
                            ),

                            const SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
