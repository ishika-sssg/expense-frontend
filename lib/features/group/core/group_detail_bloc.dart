import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './group_detail_event.dart';
import './group_detail_state.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/group_service/group_details.dart';


class GroupDetailBloc extends Bloc<GroupDetailEvent, GroupDetailState> {
  final AuthStorage authStorage;
  final GroupDetails groupDetails;

  GroupDetailBloc({required this.authStorage, required this.groupDetails}) : super(GroupDetailInitial()) {

    on<GroupDetailEvent>((event, emit) {});

    on<GetUserDetails>((GetUserDetails event, Emitter <GroupDetailState> emit) async{
      try{
        final res = await authStorage.retrieveData();
        final userId = res["user_id"];

        print("in group detil bloc $userId");

        if (userId != null) {
          final expenseRes = await groupDetails.getAllExpensesByGroupApi(event.group_id, userId.toString());
          final summaryRes = await groupDetails.getExpenseSummaryOfGroupApi(event.group_id, userId.toString());
          if(expenseRes["status"] == 200 && summaryRes["status"] == 200){
            emit(GetUserDetailsSuccess(userDetails: res, expenseDetails : expenseRes["data"], expenseSummary: summaryRes["data"]));
          }




        }

      }
      catch(err){
        emit(GetUserDetailsFailure(message: '$err'));
      }
    });
    on<GetAllExpensesEvent>((GetAllExpensesEvent event, Emitter <GroupDetailState> emit) async{
      try{
        // final res = await groupDetails.getAllExpensesByGroupApi(event.group_id);
        // if(res['status'] == 200) {
        //   emit(GetAllExpensesSuccess(allExpenseData: res));
        // }
        // else{
        //   emit(GetAllExpensesError(message: '${res['message']}'));
        //
        // }

      }
      catch(err){
        emit(GetAllExpensesError(message: '$err'));
      }
    });
  }
}
