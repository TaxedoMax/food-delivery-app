import 'package:antons_app/bloc/fragment_bloc.dart';
import 'package:antons_app/themes/main_theme/main_color_scheme.dart';
import 'package:antons_app/themes/main_theme/main_decorations.dart';
import 'package:antons_app/themes/main_theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/group_model.dart';

class SideGroupListItem extends StatefulWidget{
  final Group group;
  const SideGroupListItem({super.key, required this.group});
  @override
  State<StatefulWidget> createState() => _SideListItem();
}

class _SideListItem extends State<SideGroupListItem>{

  bool isOpened = false;
  Widget? list;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: isOpened ? widget.group.subGroups.length * 35 + 70 : 60,
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
                          // Image of group
                          Container(
                            height: 30,
                            width: 30,
                            decoration: MainDecorators.defaultBoxDecoration(MainColorScheme.background),
                            child: Image.network(
                                widget.group.imageUrl,
                                errorBuilder: (context, error, stackTrace){
                                  debugPrint('Error, while printing image: ${error.toString()}');
                                  return const Icon(Icons.error_outline);
                                }
                            ),
                          ),
                          const SizedBox(width: 4,),
                          // Name of group
                          Expanded(
                            child: Text(widget.group.name,
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
                  child: Expanded(
                      child: ListView.separated(
                        itemCount: widget.group.subGroups.length,
                        padding: const EdgeInsets.all(8),
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                        itemBuilder: (BuildContext context, int index) => InkWell(
                          onTap: (){
                            return BlocProvider.of<FragmentBloc>(context).add(GroupClickedEvent(subGroup: widget.group.subGroups[index]));
                          },
                          child: Text(
                              widget.group.subGroups[index],
                              style: MainTypography.hintTextStyle),
                        ),
                      )
                  ),),
              ],
            )
        ),
        const SizedBox(height: 10),
      ],
    );
  }

}