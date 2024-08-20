import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
  @override
   List<Object> get props => [];
}

class SignupSubmitted extends SignupEvent{
  final String username;
  final String email;
  final String password;

  const SignupSubmitted({required this.username, required this.email, required this.password});
  @override
  List<Object> get props => [username, email, password];
}


