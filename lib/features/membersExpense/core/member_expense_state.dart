
import 'package:equatable/equatable.dart';


class MemberExpenseState extends Equatable{
  @override
  List<Object> get props => [];
}
final class MemberExpenseInitial extends MemberExpenseState {}

final class GetMembersDetailsLoading extends MemberExpenseState{}
final class GetMembersDetailsSuccess extends MemberExpenseState{
  final dynamic memberDetails;
  final dynamic userDetails;


  GetMembersDetailsSuccess({required this.memberDetails, required this.userDetails});
  @override
  List<Object> get props => [memberDetails];
}

final class GetMemberDetailsFailure extends MemberExpenseState{
  final dynamic message;
  GetMemberDetailsFailure({required this.message});
  @override
  List<Object> get props => [message];
}


