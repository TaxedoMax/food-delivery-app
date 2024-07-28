import 'package:antons_app/bloc/product_list_bloc.dart';
import 'package:antons_app/widgets/fragments/groups_fragment.dart';
import 'package:antons_app/widgets/fragments/market_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FragmentBloc extends Bloc<FragmentEvent, Widget>{
  FragmentBloc(): super(const GroupsFragment()){
    on<GroupClickedEvent>(_onGroupClicked);
    on<GroupsListOpenedEvent>(_onGroupsListOpened);
  }

  _onGroupClicked(GroupClickedEvent event, Emitter emit) async {
    emit(MarketFragment(group: event.subGroup));
  }

  _onGroupsListOpened(GroupsListOpenedEvent event, Emitter emit) async {
    emit(const GroupsFragment());
  }
}

abstract class FragmentEvent{}
class GroupClickedEvent extends FragmentEvent{
  final String subGroup;
  GroupClickedEvent({required this.subGroup});
}
class GroupsListOpenedEvent extends FragmentEvent{}

// abstract class FragmentState{}