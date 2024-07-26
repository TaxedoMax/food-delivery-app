import 'dart:html';

import 'package:antons_app/models/group_model.dart';
import 'package:antons_app/widgets/fragments/groups_fragment.dart';
import 'package:antons_app/widgets/fragments/market_fragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../in_memory_db.dart';

class FragmentBloc extends Bloc<FragmentEvent, Widget>{
  FragmentBloc(): super(GroupsFragment(inMemoryList: InMemoryDB.groupsList)){
    on<GroupClickedEvent>(_onGroupClicked);
    on<GroupsListOpenedEvent>(_onGroupsListOpened);
  }

  List<Group> inMemoryList = InMemoryDB.groupsList;

  _onGroupClicked(GroupClickedEvent event, Emitter emit){
    emit(MarketFragment(group: event.subGroup));
  }

  _onGroupsListOpened(GroupsListOpenedEvent event, Emitter emit){
    emit(GroupsFragment(inMemoryList: inMemoryList));
  }
}

abstract class FragmentEvent{}
class GroupClickedEvent extends FragmentEvent{
  final String subGroup;
  GroupClickedEvent({required this.subGroup});
}
class GroupsListOpenedEvent extends FragmentEvent{}

// abstract class FragmentState{}