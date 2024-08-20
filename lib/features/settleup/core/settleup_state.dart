import 'package:equatable/equatable.dart';


class SettleupState extends Equatable{
  @override
  List<Object> get props => [];
}
final class SettleupInitial extends SettleupState {}

final class GetUserDetailsSuccess extends SettleupState{
  final dynamic userDetails;
  final dynamic unsettledTransactions;
  final dynamic expenseSummary;
  GetUserDetailsSuccess({required this.userDetails, required this.unsettledTransactions, required this.expenseSummary});
  @override
  List<Object> get props => [userDetails, unsettledTransactions, expenseSummary];
}

final class GetUserDetailsFailure extends SettleupState{
  final dynamic message;
  GetUserDetailsFailure({required this.message});
  @override
  List<Object> get props => [message];
}


final class MakeSettlementSuccess extends SettleupState {

  final dynamic response;

  MakeSettlementSuccess({required this.response});
  @override
  List<Object> get props => [response];

}

final class MakeSettlementFailure extends SettleupState{
  final dynamic message;
  MakeSettlementFailure({required this.message});
  @override
  List<Object> get props => [message];
}
