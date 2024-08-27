import 'package:equatable/equatable.dart';



class AddExpenseState extends Equatable{
  @override
  List<Object> get props => [];

}

final class AddExpenseInitial extends AddExpenseState {}
final class AddExpenseLoaded extends AddExpenseState {}
final class GetProfileUserDetails extends AddExpenseState{
  final dynamic userDetails;
  GetProfileUserDetails({required this.userDetails});
  @override
  List<Object> get props => [userDetails];
}
final class GetProfileUserDetailsError extends AddExpenseState{
  final String message;
  GetProfileUserDetailsError({required this.message});
  @override
  List<Object> get props => [message];
}

final class GetAllGroupMembersState extends AddExpenseState {
  final dynamic allMembersData;
  GetAllGroupMembersState({required this.allMembersData});
  @override
  List<Object> get props => [allMembersData];
}

final class GetAllGroupMembersErrorState extends AddExpenseState{
  final String message;
  GetAllGroupMembersErrorState({required this.message});
  @override
  List<Object> get props => [message];

}


final class SelectedMembersListState extends AddExpenseState{
  final dynamic selectedMembersData;
  SelectedMembersListState({required this.selectedMembersData});
  @override
  List<Object> get props => [selectedMembersData];
}

final class AddExpenseLoadingState extends AddExpenseState{}
final class AddExpenseSubmittedState extends AddExpenseState{
  final dynamic expense;
  AddExpenseSubmittedState({required this.expense});
  @override
  List<Object> get props => [expense];
}

final class AddExpenseNoMemberState extends AddExpenseState{
  final String message;
  AddExpenseNoMemberState({required this.message});
  @override
  List<Object> get props => [message];
}

final class AddExpenseErrorState extends AddExpenseState{
  final String message;
  AddExpenseErrorState({required this.message});
  @override
  List<Object> get props => [message];
}







