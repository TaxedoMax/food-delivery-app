import 'package:flutter/cupertino.dart';

import '../../models/group_model.dart';
import '../../themes/main_theme/main_color_scheme.dart';
import '../../themes/main_theme/main_decorations.dart';
import '../list_items/side_group_list_item.dart';

class SideGroupFragment extends StatelessWidget{
  final List<Group> groups;
  const SideGroupFragment({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (BuildContext context, int index) => SideGroupListItem(group: groups[index]),
    );
  }

}