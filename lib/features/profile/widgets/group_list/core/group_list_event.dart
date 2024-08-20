import 'package:equatable/equatable.dart';

sealed class GroupListEvent extends Equatable {
  const GroupListEvent();
  @override
  List<Object> get props => [];
}

class FetchUserGroups extends GroupListEvent {}

