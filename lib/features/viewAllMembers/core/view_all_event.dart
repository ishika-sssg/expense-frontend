import 'package:equatable/equatable.dart';

abstract class ViewAllEvent extends Equatable {
  const ViewAllEvent();

  @override
  List<Object> get props => [];
}

class GetAllMembersEvent extends ViewAllEvent{
  final String group_id;
  const GetAllMembersEvent({
    required this.group_id,

  });
  @override
  List<Object> get props => [group_id];


}

class DeleteMemberEvent extends ViewAllEvent{

  final String group_id;
  final String member_id;
  final String group_admin_id;
  // final String curr_userid;

  const DeleteMemberEvent({
    required this.group_id,
    required this.member_id,
    required this.group_admin_id,
    // required this.curr_userid,

  });

  @override
  List<Object> get props => [group_id, member_id, group_admin_id];



}

