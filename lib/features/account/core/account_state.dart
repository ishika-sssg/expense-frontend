
import 'package:equatable/equatable.dart';
class AccountState extends Equatable{
  @override
  List<Object> get props => [];
}


final class AccountInitial extends AccountState {}
final class GetUserDetailsLoading extends AccountState{}
final class GetUserDetailsSuccess extends AccountState{
  final dynamic userDetails;


  GetUserDetailsSuccess({ required this.userDetails});
  @override
  List<Object> get props => [userDetails];
}

final class GetMemberDetailsFailure extends AccountState{
  final dynamic message;
  GetMemberDetailsFailure({required this.message});
  @override
  List<Object> get props => [message];
}

