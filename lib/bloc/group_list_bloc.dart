import 'package:antons_app/repository/in_memory_db.dart';
import 'package:antons_app/models/group_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class GroupListBloc extends Bloc<GroupListEvent, GroupListState>{

  GroupListBloc(): super(GroupListUnknownState()){
    on<GroupListUpdatedEvent>(_onGroupListUpdated);
  }

  _onGroupListUpdated(GroupListUpdatedEvent event, Emitter emit) async {
    emit(GroupListUnknownState());
    var groups = await InMemoryDB.getGroupList();
    emit(GroupListKnownState(groups: groups));
  }
}


abstract class GroupListEvent{}
class GroupListUpdatedEvent extends GroupListEvent{}
class GroupListUnknownEvent extends GroupListEvent{}

abstract class GroupListState{}

class GroupListUnknownState extends GroupListState{}

class GroupListKnownState extends GroupListState{
  List<Group> groups;
  GroupListKnownState({required this.groups});
}