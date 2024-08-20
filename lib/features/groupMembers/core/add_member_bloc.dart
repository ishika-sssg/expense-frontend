import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './add_member_event.dart';
import './add_member_state.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/group_service/group_details.dart';




class AddMemberBloc extends Bloc<AddMemberEvent, AddMemberState> {

  final AuthStorage authStorage;
  final GroupDetails groupDetails;



  AddMemberBloc({required this.authStorage, required this.groupDetails}) : super(AddMemberInitial()) {
    on<AddMemberEvent>((event, emit) {});

    on<AddMemberByEmailEvent>((AddMemberByEmailEvent event, Emitter<AddMemberState> emit) async{

      // print("on button click from bloc file");
      //
      // print('email val ${event.member_email}');
      // print('group id ${event.group_id}');

      if(event.member_email.isEmpty){
        emit(AddMemberValidationError());
        return;
      }

      // print("now from bloc after adding email");
      emit(AddMemberLoaded());

      try{
        final res = await groupDetails.addMemberByEmailApi(event.member_email, event.group_id);
        print("from add member by email bloc the result is $res");
        if(res['status'] == 200){
          emit(AddMemberSuccess(memberData : res));
        }else if(res['status'] == 409){
          emit(AddMemberFailure(message  : res['message']));
        }
        else{
          emit(AddMemberFailure(message  : res['message']));

        }

      }catch(err){
        emit(AddMemberFailure(message  : 'error :$err' ));



      }

    });


    on<GetUserDetails>((GetUserDetails event, Emitter<AddMemberState> emit) async{

      try{
        final userDetails = await authStorage.retrieveData();
        print("from get userdetails event $userDetails");
        emit(GetUserDetailsSuccess(userDetails:userDetails ));



      }catch(err){
        print(err);
      }



    });
  }
}
