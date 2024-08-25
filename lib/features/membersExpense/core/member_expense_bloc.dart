import 'package:bloc/bloc.dart';
import 'package:frontend/repository/models/member_expense.dart';
import 'package:meta/meta.dart';

import './member_expense_event.dart';
import './member_expense_state.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/expense_service/expense_details.dart';

class MemberExpenseBloc extends Bloc<MemberExpenseEvent, MemberExpenseState> {
  final AuthStorage authStorage;
  final ExpenseDetails expenseDetails;

  MemberExpenseBloc({required this.authStorage, required this.expenseDetails})
      : super(MemberExpenseInitial()) {
    on<MemberExpenseEvent>((event, emit) {});

    on<GetAllExpenseByMembersEvent>((GetAllExpenseByMembersEvent event,
        Emitter<MemberExpenseState> emit) async {
      print("in original bloc");
      emit(GetMembersDetailsLoading());

      try {
        final res = await authStorage.retrieveData();
        final userId = res["user_id"];

        if (userId != null) {
          final myRes = await expenseDetails.GetExpensesMemberWise();

          print("from bloc");
          print(myRes.status);
          print(myRes.message);



          if (myRes.status == 200) {
            emit(GetMembersDetailsSuccess(
                userDetails: res, memberDetails: myRes));
          }
        } else {
          emit(GetMemberDetailsFailure(message: res["message"]));
        }
      } catch (err) {
        emit(GetMemberDetailsFailure(message: '$err'));
      }
    });
  }
}
