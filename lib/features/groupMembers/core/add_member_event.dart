
import 'package:equatable/equatable.dart';
import 'package:frontend/features/groupMembers/core/add_member_bloc.dart';

abstract class AddMemberEvent extends Equatable {
  const AddMemberEvent();

  @override
  List<Object> get props => [];
}


class GetUserDetails extends AddMemberEvent{

}
class AddMemberByEmailEvent extends AddMemberEvent {


  final String member_email;
  final String group_id;

  const AddMemberByEmailEvent({
    required this.member_email,
    required this.group_id,

  });

  @override
  List<Object> get props => [member_email, group_id];



}

