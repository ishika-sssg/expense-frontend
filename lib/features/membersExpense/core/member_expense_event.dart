

import 'package:equatable/equatable.dart';

abstract class MemberExpenseEvent extends Equatable {
  const MemberExpenseEvent();

  @override
  List<Object> get props => [];
}

class GetAllExpenseByMembersEvent extends MemberExpenseEvent{
  // final String user_id;
  // final String user_id;

  const GetAllExpenseByMembersEvent();
  @override
  List<Object> get props => [];

}




