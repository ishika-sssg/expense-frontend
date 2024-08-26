import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './add_expense_event.dart';
import './add_expense_state.dart';
import 'package:frontend/repository/services/group_service/group_details.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/expense_service/expense_details.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  final GroupDetails groupDetails;
  final AuthStorage authStorage;
  final ExpenseDetails expenseDetails;

  AddExpenseBloc({required this.authStorage, required this.groupDetails, required this.expenseDetails})
      : super(AddExpenseInitial()) {
    on<AddExpenseEvent>((event, emit) {});
    on<GetUserDetails>((GetUserDetails event, Emitter<AddExpenseState> emit) async {
      emit(AddExpenseLoaded());
      try {
        final res = await authStorage.retrieveData();

        emit(GetProfileUserDetails(
          userDetails: res,
        ));
      } catch (e) {
        emit(GetProfileUserDetailsError(message: '$e'));
        print(e);
      }
    });
    on<FetchAllGroupMembersEvent>((FetchAllGroupMembersEvent event, Emitter<AddExpenseState> emit) async{
try{
  final res = await groupDetails.getAllMembersOfGroupApi(event.groupId);
  print("from create expense bloc $res");
  if(res['status'] == 200){
    emit(GetAllGroupMembersState(allMembersData: res["data"]["details"]));
  }
  else if(res['status'] == 204){
    emit(GetAllGroupMembersErrorState(message: res["message"]));
  }
  else{
    emit(GetAllGroupMembersErrorState(message: res["message"]));
  }


}catch(err){
  emit(GetAllGroupMembersErrorState(message: '$err'));

}
    });

  //   for creating expense:
    on<AddExpenseOnClick>((AddExpenseOnClick event, Emitter<AddExpenseState> emit) async{
      emit(AddExpenseLoadingState());
        try{
          var res= await expenseDetails.createExpenseApi(event.new_expense);
          print('res from add expense bloc $res');
          if(res['status'] == 200){
            emit(AddExpenseSubmittedState(expense: res['data']));
          }else{
            emit(AddExpenseErrorState(message: res['message']));
          }
        }catch(err){
          print(err);
          emit(AddExpenseErrorState(message: '$err'));
        }
    });

  }
}
