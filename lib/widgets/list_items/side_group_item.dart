import 'package:antons_app/bloc/fragment_bloc.dart';
import 'package:antons_app/themes/main_theme/main_color_scheme.dart';
import 'package:antons_app/themes/main_theme/main_decorations.dart';
import 'package:antons_app/themes/main_theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/group_model.dart';

class SideGroupItem extends StatefulWidget{
  final Group group;
  const SideGroupItem({super.key, required this.group});
  @override
  State<StatefulWidget> createState() => _SideGroupItemState();
}

class _SideGroupItemState extends State<SideGroupItem>{

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
                  child: ListView.separated(
                    itemCount: widget.group.subGroups.length,
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: (){
                        return BlocProvider.of<FragmentBloc>(context).add(GroupClickedEvent(subGroup: widget.group.subGroups[index]));
                      },
                      child: Text(
                          widget.group.subGroups[index],
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