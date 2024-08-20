import 'package:equatable/equatable.dart';


class ViewAllState extends Equatable{
  @override
  List<Object> get props => [];
}
final class ViewAllInitial extends ViewAllState {}

final class ViewAllMembersSuccess extends ViewAllState{
  final dynamic membersData;
  final dynamic userData;
  ViewAllMembersSuccess({required this.membersData, required this.userData});
  @override
  List<Object> get props => [membersData, userData];
}


final class ViewAllMembersFailure extends ViewAllState{
  final dynamic message;
  ViewAllMembersFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class MemberDeleteSuccess extends ViewAllState{}

final class AdminOnlyDeleteError extends ViewAllState{
  final dynamic message;
  AdminOnlyDeleteError({required this.message});
  @override
  List<Object> get props => [message];
}

final class MemberDeleteFailure extends ViewAllState{
  final dynamic message;
  MemberDeleteFailure({required this.message});
  @override
  List<Object> get props => [message];
}
