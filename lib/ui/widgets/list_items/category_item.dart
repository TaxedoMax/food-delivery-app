import 'package:antons_app/bloc/fragment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/category_model.dart';
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
      SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: category.subCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index){
            return Row(
              children: [
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => BlocProvider.of<FragmentBloc>(context).add(CategoryClickedEvent(subCategory: category.subCategories[index])),
                  child: Container(
                    decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.background),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                    children: [
                        Text(
                            category.subCategories[index],
                            style: MainTypography.defaultTextStyle
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          padding: const EdgeInsets.all(5),
                          child: const ColoredBox(color: MainColorScheme.main),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10)
              ],
            );
          },
        ),
      )
      ],
    );
  }

}