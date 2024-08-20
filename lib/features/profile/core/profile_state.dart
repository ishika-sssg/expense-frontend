
import 'package:equatable/equatable.dart';

class ProfileState extends Equatable{
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String email;
  final String user_name;
  ProfileLoaded({required this.email, required this.user_name});
  @override
  List<Object> get props => [email, user_name];
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError({required this.message});
  @override
  List<Object> get props => [message];
}

class ProfileUserGroupsLoaded extends ProfileState{}
class ProfileUserGroupsData extends ProfileState{
  final dynamic groupsData;
  ProfileUserGroupsData({required this.groupsData});
  @override
  List<Object> get props => [groupsData];
}

// class ProfileUserGroupsError extends ProfileState {
//   final String message;
//   ProfileUserGroupsError({required this.message});
//   @override
//   List<Object> get props => [message];
// }
//

