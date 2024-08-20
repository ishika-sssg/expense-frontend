import 'package:equatable/equatable.dart';

abstract class AddExpenseEvent extends Equatable{
  const AddExpenseEvent();

  @override
  List<Object> get props => [];

}

class GetUserDetails extends AddExpenseEvent {
}

class FetchAllGroupMembersEvent extends AddExpenseEvent{
  final String groupId;
  FetchAllGroupMembersEvent(this.groupId);
  @override
  List<Object> get props => [groupId];
}

class SelectMemberEvent extends AddExpenseEvent {
  final String member;
  SelectMemberEvent(this.member);
  @override
  List<Object> get props => [member];
}

class AddExpenseOnClick extends AddExpenseEvent{
  final dynamic new_expense;
  AddExpenseOnClick(this.new_expense);
  @override
  List<Object> get props => [new_expense];

}