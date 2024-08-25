import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetLoggedInUserDetails extends AccountEvent{
  // final String user_id;
  // final String user_id;

  const GetLoggedInUserDetails();
  @override
  List<Object> get props => [];

}

