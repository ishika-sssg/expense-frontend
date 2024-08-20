import 'package:bloc/bloc.dart';
import './add_group_event.dart';
import  './add_group_state.dart';
import 'package:frontend/repository/services/group_service/group_details.dart';


class AddGroupBloc extends Bloc<AddGroupEvent, AddGroupState> {

  final GroupDetails groupDetails;

  AddGroupBloc({required this.groupDetails}) : super(AddGroupInitial()) {
    on<AddGroupEvent>((event, emit) {});

    on<AddGroupSubmittedEvent>((AddGroupSubmittedEvent event, Emitter<AddGroupState> emit) async{
      emit(AddGroupLoaded());

      try{
        print(event.grp_name);
        final res = await groupDetails.createGroup(event.grp_name, event.grp_desc, event.grp_category);
        print("from create group bloc $res");
        if(res['status'] == 200){
          emit(AddGroupSubmitted(newGroupData : res));
        }else{
          emit(AddGroupError(message  : res['message']));
        }

      }catch(err){
        emit(AddGroupError(message: '$err'));
        print(err);

      }





    });
  }
}
