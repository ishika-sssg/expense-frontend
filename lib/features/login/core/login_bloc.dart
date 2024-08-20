// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'login_event.dart';
// part 'login_state.dart';
//
// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   LoginBloc() : super(LoginInitial()) {
//     on<LoginEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }


import 'package:bloc/bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:frontend/repository/services/auth_service/auth_api.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthApi authApi;

  LoginBloc({ required this.authApi}) : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) {});

    on<LoginSubmitted>((event, emit) async {
      emit(isSubmitting(isLoading: true));
      emit(isSubmitting(isLoading: false));


      try {
        var res = await authApi.loginUser(event.email, event.password);
        // print("from login bloc");
        // print(res['success']);
        if (res is Map && res['status'] == 200) {
          emit(isSuccess(success: true));


        } else {
          emit(isFailure(failure: true, errorMessage : res['message']));

        }
      } catch (err) {
        print("from login bloc file ");
        print(err);
      }




    });
  }
}




