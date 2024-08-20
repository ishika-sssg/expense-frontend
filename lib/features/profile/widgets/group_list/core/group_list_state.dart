
import 'package:equatable/equatable.dart';

class GroupListState extends Equatable{
  @override
  List<Object> get props => [];
}
class GroupListInitial extends GroupListState {}


class GroupListLoaded extends GroupListState{}




class GroupListData extends GroupListState{
  final dynamic groupsData;
  GroupListData({required this.groupsData});
  @override
  List<Object> get props => [groupsData];
}
class ProfileUserData extends GroupListState{
  final dynamic profileUser;
  ProfileUserData({required this.profileUser});
  @override
  List<Object> get props => [profileUser];
}


class GroupListError extends GroupListState {
  final String message;
  GroupListError({required this.message});
  @override
  List<Object> get props => [message];
}

