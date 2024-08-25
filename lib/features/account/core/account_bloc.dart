import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './account_event.dart';
import './account_state.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';



class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AuthStorage authStorage;

  AccountBloc({required this.authStorage}) : super(AccountInitial()) {
    on<AccountEvent>((event, emit) {});

    on<GetLoggedInUserDetails>((GetLoggedInUserDetails event,  Emitter<AccountState> emit) async{

      emit(GetUserDetailsLoading());
      try{
        final res = await authStorage.retrieveData();
        emit(GetUserDetailsSuccess(userDetails: res));

      }catch(err){
        emit(GetMemberDetailsFailure(message: err));
      }

    });
  }
}
