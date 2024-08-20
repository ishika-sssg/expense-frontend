import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/repository/services/group_service/group_details.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';



import './group_list_event.dart';
import './group_list_state.dart';

class GroupListBloc extends Bloc<GroupListEvent, GroupListState> {
  final GroupDetails groupDetails;
  final AuthStorage authStorage;


  GroupListBloc({required this.groupDetails, required this.authStorage}) : super(GroupListInitial()) {
     on<GroupListEvent>((event, emit){});



    on<FetchUserGroups>((FetchUserGroups event, Emitter<GroupListState> emit) async{
      // TODO: implement event handler
      emit(GroupListLoaded());

      try {

            final res = await groupDetails.getGroupsByUserid();
            // final loggedUserDetails = await authStorage.retrieveData();

            print("from group list bloc $res");
            if(res['status'] == 200){
              emit(GroupListData(
                  groupsData: res,
              ));

              // emit(ProfileUserData(profileUser : loggedUserDetails));

            }else{
              emit(GroupListError(message: res['message']));

            }

          } catch (e) {
            emit(GroupListError(message: '$e'));
            print(e);
          }
    });
  }
}
