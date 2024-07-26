import 'package:antons_app/widgets/list_items/group_list_item.dart';
import 'package:flutter/cupertino.dart';

import '../../models/group_model.dart';

class GroupsFragment extends StatefulWidget{
  final List<Group> inMemoryList;
  const GroupsFragment({super.key, required this.inMemoryList});
  @override
  State<StatefulWidget> createState() => _DefaultFragment();
}

class _DefaultFragment extends State<GroupsFragment>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.inMemoryList.length,
            itemBuilder: (BuildContext context, int index) => GroupListItem(group: widget.inMemoryList[index]),
          ),
        ),
      ],
    );
  }

}