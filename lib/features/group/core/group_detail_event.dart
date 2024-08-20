
import 'package:equatable/equatable.dart';

abstract class GroupDetailEvent extends Equatable {
  const GroupDetailEvent();

  @override
  List<Object> get props => [];
}


class GetUserDetails extends GroupDetailEvent{
  final String group_id;
  // final String user_id;

  const GetUserDetails({required this.group_id});
  @override
  List<Object> get props => [group_id];

}

class GetAllExpensesEvent extends GroupDetailEvent{
  final String group_id;
  const GetAllExpensesEvent({required this.group_id});
  @override
  List<Object> get props => [group_id];


}

