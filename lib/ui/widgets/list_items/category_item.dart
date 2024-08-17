import 'package:antons_app/bloc/fragment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/category.dart';
import '../../themes/main_theme/main_color_scheme.dart';
import '../../themes/main_theme/main_decorations.dart';
import '../../themes/main_theme/typography.dart';


class CategoryItem extends StatelessWidget{
  final Category category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            category.name,
            style: MainTypography.headingTextStyle
        ),
      const SizedBox(
        height: 10,
      ),
      LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth ~/ 200,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 10 / 12
              ),
              shrinkWrap: true,
              itemCount: category.subCategories.length,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index){
                return InkWell(
                  onTap: () => BlocProvider.of<FragmentBloc>(context).add(CategoryClickedEvent(subCategory: category.subCategories[index])),
                  child: Container(
                    decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.background),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                    children: [
                        Text(
                            category.subCategories[index].name,
                            style: MainTypography.defaultTextStyle
                        ),
                        const SizedBox(height: 10,),
                        Image.network(
                            category.subCategories[index].imageUrl,
                            height: 150,
                            width: 150,
                            errorBuilder:
                              (context, error, stackTrace) =>
                                  Image.asset(
                                    'assets/images/no_image.png',
                                    height: 150,
                                    width: 150
                                  )
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      )
      ],
    );
  }

}