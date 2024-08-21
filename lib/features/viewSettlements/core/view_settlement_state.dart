import 'package:equatable/equatable.dart';

class ViewSettlementState extends Equatable{
  @override
  List<Object> get props => [];
}

final class ViewSettlementInitial extends ViewSettlementState {}

final class AllSettlementSuccess extends ViewSettlementState{
  final dynamic allData;
  final dynamic userData;
  AllSettlementSuccess({required this.allData, required this.userData});
  @override
  List<Object> get props => [allData, userData];
}


final class AllSettlementFailure extends ViewSettlementState{
  final dynamic message;
  AllSettlementFailure({required this.message});
  @override
  List<Object> get props => [message];
}