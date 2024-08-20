import 'package:equatable/equatable.dart';


class AddGroupState extends Equatable{
  @override
  List<Object> get props => [];

}

final class AddGroupInitial extends AddGroupState {}
final class AddGroupLoaded extends AddGroupState {}

final class AddGroupSubmitted extends AddGroupState{
  final dynamic newGroupData;
  AddGroupSubmitted({required this.newGroupData});
  @override
  List<Object> get props => [newGroupData];
}

final class AddGroupError extends AddGroupState{
  final String message;
  AddGroupError({required this.message});
  @override
  List<Object> get props => [message];
}


