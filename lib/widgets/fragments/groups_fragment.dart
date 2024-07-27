import 'package:antons_app/bloc/groups_list_bloc.dart';
import 'package:antons_app/widgets/list_items/group_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/group_model.dart';

class GroupsFragment extends StatefulWidget{
  const GroupsFragment({super.key});
  @override
  State<StatefulWidget> createState() => _GroupsFragmentState();
}

class _GroupsFragmentState extends State<GroupsFragment>{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsListBloc, GroupsListState>(
      builder: (context, state) {
        if(state is GroupsListUnknownState){
          return const CircularProgressIndicator();
        }
        else if(state is GroupsListKnownState){
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.groups.length,
                  itemBuilder: (BuildContext context, int index) => GroupItem(group: state.groups[index]),
                ),
              ),
            ],
          );
        }
        throw Exception("Unknown state in GroupsListBloc");
      }
    );
  }

}