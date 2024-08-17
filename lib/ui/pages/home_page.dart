import 'package:antons_app/bloc/fragment_bloc.dart';
import 'package:antons_app/bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/cart_bloc.dart';
import '../../bloc/product_list_bloc.dart';
import '../themes/main_theme/main_color_scheme.dart';
import '../themes/main_theme/main_decorations.dart';
import '../themes/main_theme/typography.dart';
import '../widgets/fragments/cart_fragment.dart';
import '../widgets/fragments/side_categories_fragment.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  bool _cartIsOpened = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (BuildContext context, state) {
        if(state is CartUploadedWithErrorState){
          if(state.errorStatus == 422){
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Количество товаров в корзине'),
                  content: const Text(
                      'Извините, количество товаров в корзине изменилось.'
                          'Возможно вы открыли приложение сразу с нескольких устройств '
                          'или количество товара на складе изменилось'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Ок')
                    )
                  ],
                )
            );
          }
          else if(state.errorStatus == 401){
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Ошибка авторизации'),
                  content: const Text('Для оформления заказа необходимо войти в аккаунт'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          context.pop('/login');
                          context.push('/login');
                        },
                        child: const Text('Ок')
                    )
                  ],
                )
            );
          }
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
          title: const Text(
            'S-рынок',
            style: MainTypography.headingTextStyle,
          ),
          actions: [
          Container(
            width: 300,
            height: 50,
            decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.background),
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const TextField(
              style: MainTypography.defaultTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.search),
                hintText: 'Найти на рынке',
                hintStyle: MainTypography.hintTextStyle,
                ),
            ),
          ),
            IconButton(
                onPressed: () => context.push('/login'),
                icon: const Icon(Icons.account_circle))
          ],
        ),

        body: MultiBlocProvider(
          providers: [
            BlocProvider<FragmentBloc>(
                create: (context) => FragmentBloc()..add(CategoryListOpenedEvent())
            ),
            BlocProvider<CategoryListBloc>(
                create: (context) => CategoryListBloc()..add(CategoryListUpdatedEvent())
                ),
            BlocProvider<ProductListBloc>(
              create: (context) => ProductListBloc(),
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if(constraints.maxWidth > 1000) {
                  return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Side list (left)
                    Container(
                      width: 230,
                      alignment: Alignment.center,
                      decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.backgroundShadow),
                      padding: const EdgeInsets.all(10),
                      child: const SideCategoriesFragment()
                    ),

                    const SizedBox(width: 20),

                    // Main space with goods
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.backgroundShadow),
                        child: BlocBuilder<FragmentBloc, Widget>(
                            builder: (context, fragment) {
                            return fragment;
                          }
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Basket
                    Container(
                      width: 350,
                      padding: const EdgeInsets.all(10),
                      decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.backgroundShadow),
                      child: const CartFragment(),
                    ),
                  ],
                );
                }
                else{
                  // TODO: change if-else to bloc
                  // Full-screen cart
                  if(_cartIsOpened){
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.backgroundShadow),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _cartIsOpened = false;
                                });
                              },
                              icon: const Icon(Icons.arrow_back)
                          ),
                          const Expanded(child: CartFragment()),
                        ],
                      ),
                    );
                  }
                  else {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.backgroundShadow),
                      child: Stack(
                        children: [
                          BlocBuilder<FragmentBloc, Widget>(
                              builder: (context, fragment) {
                                return fragment;
                              }
                          ),
                          Positioned.directional(
                            textDirection: TextDirection.rtl,
                            start: 0,
                            //width: 150,
                            bottom: 0,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _cartIsOpened = true;
                                });
                              },
                              style: MainDecorators.defaultButtonStyle(),
                              child: const Text('Корзина', style: MainTypography.buttonTextStyle),
                            ),
                          ),
                        ]
                      ),
                    );
                  }
                }
              }
            ),
          ),
        )
      ),
    );
  }

}