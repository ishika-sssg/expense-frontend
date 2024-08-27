import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './view_all_event.dart';
import './view_all_state.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/group_service/group_details.dart';


class ViewAllBloc extends Bloc<ViewAllEvent, ViewAllState> {

  final AuthStorage authStorage;
  final GroupDetails groupDetails;



  ViewAllBloc({required this.authStorage, required this.groupDetails}) : super(ViewAllInitial()) {
    on<ViewAllEvent>((event, emit) {});

    on<GetAllMembersEvent>((GetAllMembersEvent event, Emitter<ViewAllState> emit) async{
      // print("from getall member bloc file ${event.group_id}");
      emit(ViewAllMembersLoading());

      try{
        final res = await groupDetails.getAllMembersOfGroupApi(event.group_id);
        final userDetail = await authStorage.retrieveData();

        // print(userDetail);
        // print("from bloc file $res");
        // print("the status is ${res['status']}");
        if(res['status'] == 200){
          emit(ViewAllMembersSuccess(membersData: res, userData: userDetail));
        }
        else if (res['status'] == 204){
          // print("emiiting nodata stat from bloc");
          emit(ViewAllMembersNoData(message: '${res['message']}'));
        }
        else{
          emit(ViewAllMembersFailure(message: '${res['message']}'));

        }
      }catch(err){
        emit(ViewAllMembersFailure(message: '$err'));

      }


    });

    on<DeleteMemberEvent>((DeleteMemberEvent event, Emitter<ViewAllState> emit) async{

      // print("from getall member bloc file delete event ${event.group_id} ${event.member_id}");
      try{
        final res = await groupDetails.deleteMemberFromGroupApi(event.group_id, event.member_id, event.group_admin_id);
        if(res['status'] == 200){
          emit(MemberDeleteSuccess());
        }
        else if (res['status'] == 400){
          emit(AdminOnlyDeleteError(message: '${res['message']}'));
        }
        else{
          emit(MemberDeleteFailure(message: '${res['message']}'));

        }

      }catch(err){
        emit(MemberDeleteFailure(message: '$err'));

      }




    });


  }
}
