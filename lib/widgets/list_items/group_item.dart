import 'package:antons_app/bloc/fragment_bloc.dart';
import 'package:antons_app/themes/main_theme/main_color_scheme.dart';
import 'package:antons_app/themes/main_theme/main_decorations.dart';
import 'package:antons_app/themes/main_theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/group_model.dart';

class GroupItem extends StatelessWidget{
  final Group group;
  const GroupItem({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            group.name,
            style: MainTypography.headingTextStyle
        ),
      SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: group.subGroups.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index){
            return Row(
              children: [
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => BlocProvider.of<FragmentBloc>(context).add(GroupClickedEvent(subGroup: group.subGroups[index])),
                  child: Container(
                    decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.background),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                    children: [
                        Text(
                            group.subGroups[index],
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