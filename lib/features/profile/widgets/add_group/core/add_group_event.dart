
import 'package:equatable/equatable.dart';

abstract class AddGroupEvent extends Equatable {
  const AddGroupEvent();

  @override
  List<Object> get props => [];
}

class AddGroupDetails extends AddGroupEvent {}
class AddGroupSubmittedEvent extends AddGroupEvent {
  final String grp_name;
  final String grp_desc;
  final String grp_category;

  const AddGroupSubmittedEvent({
    required this.grp_name,
    required this.grp_desc,
    required this.grp_category,

  });

  @override
  List<Object> get props => [grp_name, grp_desc, grp_category];
//

}
