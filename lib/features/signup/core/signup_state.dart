import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  @override
  List<Object> get props => [];
}
class SignupInitialState extends SignupState {}

class isSubmitting extends SignupState{
  final bool isLoading;
  isSubmitting({required this.isLoading});

}
class isSuccess extends SignupState{
  final bool success;
  isSuccess({required this.success});

}
class isFailure extends SignupState{
  final bool failure;
  final String errorMessage;
  isFailure({required this.failure, required this.errorMessage});

  @override
  List<Object> get props => [ isSubmitting, isSuccess, isFailure];
}