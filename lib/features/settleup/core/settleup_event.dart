import 'package:equatable/equatable.dart';

abstract class SettleupEvent extends Equatable {
  const SettleupEvent();

  @override
  List<Object> get props => [];
}

class GetAllSettlementDetailsEvent extends SettleupEvent{
  final String group_id;
  // final String user_id;

  const GetAllSettlementDetailsEvent({required this.group_id});
  @override
  List<Object> get props => [group_id];

}


class MakeSettlementEvent extends SettleupEvent{
  final String trans_id;
  final String user_id;

  const MakeSettlementEvent({required this.trans_id, required this.user_id});
  @override
  List<Object> get props => [trans_id, user_id];

}


