import 'package:antons_app/repository/main_repository.dart';
import 'package:antons_app/models/group_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class GroupListBloc extends Bloc<GroupListEvent, GroupListState>{

  GroupListBloc(): super(GroupListUnknownState()){
    on<GroupListUpdatedEvent>(_onGroupListUpdated);
  }

  _onGroupListUpdated(GroupListUpdatedEvent event, Emitter emit) async {
    emit(GroupListUnknownState());
    var groups = await MainRepository.getGroupList();
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