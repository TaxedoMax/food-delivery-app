import 'package:antons_app/bloc/fragment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/category.dart';
import '../../themes/main_theme/main_color_scheme.dart';
import '../../themes/main_theme/main_decorations.dart';
import '../../themes/main_theme/typography.dart';


class SideCategoryItem extends StatefulWidget{
  final Category category;
  const SideCategoryItem({super.key, required this.category});
  @override
  State<StatefulWidget> createState() => _SideCategoryItemState();
}

class _SideCategoryItemState extends State<SideCategoryItem>{

  bool isOpened = false;
  Widget? list;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(4),
            decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.background),
            child: Column(
              children: [
                InkWell(
                    onTap: (){
                      isOpened = !isOpened;
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: 50,
                      child: Row(
                        children: [
                          // Image of category
                          Container(
                            height: 30,
                            width: 30,
                            decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.background),
                            child: Image.network(
                                widget.category.imageUrl,
                                errorBuilder: (context, error, stackTrace){
                                  return Image.asset('assets/images/no_image.png');
                                }
                            ),
                          ),
                          const SizedBox(width: 4,),
                          // Name of category
                          Expanded(
                            child: Text(widget.category.name,
                              style: MainTypography.defaultTextStyle,
                            )
                          )
                        ],
                      ),
                    )
                ),

                // Sublist
                Visibility(
                  visible: isOpened,
                  child: ListView.separated(
                    itemCount: widget.category.subCategories.length,
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: (){
                        return BlocProvider.of<FragmentBloc>(context).add(CategoryClickedEvent(subCategory: widget.category.subCategories[index]));
                      },
                      child: Text(
                          widget.category.subCategories[index].name,
                          style: MainTypography.hintTextStyle),
                    ),
                  ),),
              ],
            )
        ),
        const SizedBox(height: 10),
      ],
    );
  }

}