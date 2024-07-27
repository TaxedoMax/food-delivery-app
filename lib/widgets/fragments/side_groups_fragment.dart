import 'package:antons_app/bloc/groups_list_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/group_model.dart';
import '../../themes/main_theme/main_color_scheme.dart';
import '../../themes/main_theme/main_decorations.dart';
import '../list_items/side_group_item.dart';

class SideGroupFragment extends StatelessWidget{
  const SideGroupFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsListBloc, GroupsListState>(
      builder: (context, state) {
        if(state is GroupsListUnknownState){
          return const CircularProgressIndicator();
        }
        else if (state is GroupsListKnownState){
          return ListView.builder(
            itemCount: state.groups.length,
            itemBuilder: (BuildContext context, int index) => SideGroupItem(group: state.groups[index]),
          );
        }
        throw Exception("Unexpected state (GroupsListBloc, SideGroupsFragment)");
      }
    );
  }

}