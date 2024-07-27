import 'package:antons_app/in_memory_db.dart';
import 'package:antons_app/models/group_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class GroupsListBloc extends Bloc<GroupsListEvent, GroupsListState>{

  GroupsListBloc(): super(GroupsListUnknownState()){
    on<GroupsListUpdatedEvent>(_onGroupsListUpdated);
  }

  _onGroupsListUpdated(GroupsListUpdatedEvent event, Emitter emit) async {
    emit(GroupsListUnknownState());
    var groups = await InMemoryDB.groupsList();
    emit(GroupsListKnownState(groups: groups));
  }
}


abstract class GroupsListEvent{}
class GroupsListUpdatedEvent extends GroupsListEvent{}
class GroupsListUnknownEvent extends GroupsListEvent{}

abstract class GroupsListState{}

class GroupsListUnknownState extends GroupsListState{}

class GroupsListKnownState extends GroupsListState{
  List<Group> groups;
  GroupsListKnownState({required this.groups});
}