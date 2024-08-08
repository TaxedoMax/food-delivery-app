import 'package:antons_app/ui/themes/main_theme/main_color_scheme.dart';
import 'package:antons_app/ui/themes/main_theme/main_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/auth_bloc.dart';
import '../themes/main_theme/typography.dart';
import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
          title: const Text('Регистрация',
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
                    decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.backgroundShadow),
                    width: 500,
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
                            // Поле для ввода имени
                            TextFormField(
                              controller: _loginController,
                              decoration: const InputDecoration(
                                labelText: 'Имя',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Введите имя';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),

                            // Поле для ввода email
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Введите email';
                                }
                                if (!RegExp(r"[a-z0-9]+@[a-z]+\.[a-z]{2,}")
                                    .hasMatch(value)) {
                                  return 'Неверный формат email';
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
                                if (value.length < 6) {
                                  return 'Пароль должен быть не менее 6 символов';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),

                            // Поле для подтверждения пароля
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Подтвердите пароль',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Повторите пароль';
                                }
                                if (_passwordController.text != value) {
                                  return 'Пароли не совпадают';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 32.0),

                            // Кнопка "Зарегистрироваться"
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(RegistrationRequestedEvent(_loginController.text, _emailController.text, _passwordController.text));
                                }
                              },
                              child: const Text('Зарегистрироваться'),
                            ),
                            const SizedBox(height: 16.0),

                            // Кнопка "Войти"
                            TextButton(
                              onPressed: (){
                                context.go('/login');
                              },
                              child: const Text('Войти'),
                            ),
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
