

import 'package:equatable/equatable.dart';

class LoginState extends Equatable{
  @override
  List<Object> get props => [];

}
class LoginInitialState extends LoginState {}

class isSubmitting extends LoginState{
  final bool isLoading;
  isSubmitting({required this.isLoading});

}
class isSuccess extends LoginState{
  final bool success;
  isSuccess({required this.success});

}
class isFailure extends LoginState{
  final bool failure;
  final String errorMessage;
   isFailure({required this.failure, required this.errorMessage});

  @override
  List<Object> get props => [failure, errorMessage];
}


// class LoginState extends Equatable {
//   // final String email;
//   // final String password;
//   final bool isSubmitting;
//   final bool isSuccess;
//   final bool isFailure;
//
//   const LoginState({
//     // required this.email,
//     // required this.password,
//     required this.isSubmitting,
//     required this.isSuccess,
//     required this.isFailure,
//   });
//
//   factory LoginState.initial() {
//     return LoginState(
//       // email: '',
//       // password: '',
//       isSubmitting: false,
//       isSuccess: false,
//       isFailure: false,
//     );
//   }
//
//   factory LoginState.loading() {
//     return LoginState(
//       // email: '',
//       // password: '',
//       isSubmitting: true,
//       isSuccess: false,
//       isFailure: false,
//     );
//   }
//
//   factory LoginState.failure() {
//     return LoginState(
//       // email: '',
//       // password: '',
//       isSubmitting: false,
//       isSuccess: false,
//       isFailure: true,
//     );
//   }
//
//   factory LoginState.success() {
//     return LoginState(
//       // email: '',
//       // password: '',
//       isSubmitting: false,
//       isSuccess: true,
//       isFailure: false,
//     );
//   }
//
//   LoginState copyWith({
//     // String? email,
//     // String? password,
//     bool? isSubmitting,
//     bool? isSuccess,
//     bool? isFailure,
//   }) {
//     return LoginState(
//       // email: email ?? this.email,
//       // password: password ?? this.password,
//       isSubmitting: isSubmitting ?? this.isSubmitting,
//       isSuccess: isSuccess ?? this.isSuccess,
//       isFailure: isFailure ?? this.isFailure,
//     );
//   }
//
//   @override
//   List<Object> get props => [ isSubmitting, isSuccess, isFailure];
// }

