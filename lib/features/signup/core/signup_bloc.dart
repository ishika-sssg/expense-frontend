import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'signup_event.dart';
import 'signup_state.dart';
import 'package:frontend/repository/services/auth_service/auth_api.dart';



class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthApi authApi;

  SignupBloc({required this.authApi}) : super(SignupInitialState()) {
    on<SignupEvent>((event, emit) {});
    on<SignupSubmitted>((event, emit) async{
      emit(isSubmitting(isLoading: true));
      emit(isSubmitting(isLoading: false));

      try{
        var res = await authApi.registerUser(event.username, event.email, event.password);
        // var result = res.data;
        // debugPrint(result);
        if(res['status'] == 200 ){
          emit(isSuccess(success : true));
        }else{
          emit(isFailure(failure: false, errorMessage: " ${res['message']}"));
        }

      }catch(err){
        print(err);
      }

    });

  }





}

