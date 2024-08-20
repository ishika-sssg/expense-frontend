import 'package:equatable/equatable.dart';

class AddMemberState extends Equatable{
  @override
  List<Object> get props => [];
}

final class AddMemberInitial extends AddMemberState {}

final class GetUserDetailsSuccess extends AddMemberState{
  final dynamic userDetails;
  GetUserDetailsSuccess({required this.userDetails});
  @override
  List<Object> get props => [userDetails];
}

final class AddMemberLoaded extends AddMemberState{}

final class AddMemberSuccess extends AddMemberState {
  final dynamic memberData;
  AddMemberSuccess({required this.memberData});
  @override
  List<Object> get props => [memberData];
}

final class AddMemberFailure extends AddMemberState {
  final dynamic message;
  AddMemberFailure({required this.message});
  @override
  List<Object> get props => [message];
}


final class AddMemberValidationError extends AddMemberState {
}

