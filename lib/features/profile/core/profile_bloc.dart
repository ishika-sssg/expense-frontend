import 'package:bloc/bloc.dart';
import  './profile_event.dart';
import  './profile_state.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/group_service/group_details.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthStorage authStorage;
  final GroupDetails groupDetails;


  ProfileBloc({required this.authStorage, required this.groupDetails}) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    //adding logic to another event :
    on<FetchUserDetails>((event, emit) async {
      try {
        final res = await authStorage.retrieveData();
        // var val = res.data;
        print(res);
        emit(ProfileLoaded(
            email: res['user_email'], user_name: res['user_name']));

      } catch (e) {
        emit(ProfileError(message: "error"));
        // emit(ProfileUserGroupsError(message: '$e'));

      }
    });


  }
}
