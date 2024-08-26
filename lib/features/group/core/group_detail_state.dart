import 'package:equatable/equatable.dart';

class GroupDetailState extends Equatable{
  @override
  List<Object> get props => [];
}

final class GroupDetailInitial extends GroupDetailState {}

final class GetUserDetailsSuccess extends GroupDetailState{
  final dynamic userDetails;
  final dynamic expenseDetails;
  final dynamic expenseSummary;
  GetUserDetailsSuccess({required this.userDetails, required this.expenseDetails, required this.expenseSummary});
  @override
  List<Object> get props => [userDetails, expenseDetails, expenseSummary];
}
final class GetUserDetailsFailure extends GroupDetailState{
  final dynamic message;
  GetUserDetailsFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class GetAllExpensesLoading extends GroupDetailState{}
final class GetAllExpensesSuccess extends GroupDetailState{
  final dynamic allExpenseData;
  GetAllExpensesSuccess({required this.allExpenseData});
  @override
  List<Object> get props => [allExpenseData];
}

final class GetAllExpensesError extends GroupDetailState{
  final dynamic message;
  GetAllExpensesError({required this.message});
  @override
  List<Object> get props => [message];
}

