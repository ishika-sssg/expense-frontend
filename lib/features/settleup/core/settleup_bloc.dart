import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './settleup_state.dart';
import './settleup_event.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/expense_service/expense_details.dart';



class SettleupBloc extends Bloc<SettleupEvent, SettleupState> {

  final AuthStorage authStorage;
  final ExpenseDetails expenseDetails;

  SettleupBloc({required this.authStorage, required this.expenseDetails}) : super(SettleupInitial()) {
    on<SettleupEvent>((event, emit) {});

    on<GetAllSettlementDetailsEvent>((GetAllSettlementDetailsEvent event, Emitter <SettleupState> emit) async{
        print("in original bloc");
      try{
        final res = await authStorage.retrieveData();
        final userId = res["user_id"];

        print("in settlement bloc $userId");

        if (userId != null) {
          final unsettledTrans = await expenseDetails.getAllUnsettledTransactionsApi(event.group_id, res["user_id"].toString());
          print("from settlement transaction $unsettledTrans");
          if(unsettledTrans["status"] == 200){
            emit(GetUserDetailsSuccess(userDetails: res, unsettledTransactions : unsettledTrans["data"], expenseSummary: ""));
          }

        }
        else{
          emit(GetUserDetailsFailure(message : res["message"]));
        }

      }
      catch(err){
        emit(GetUserDetailsFailure(message: '$err'));
      }


    });

    on<MakeSettlementEvent>((MakeSettlementEvent event, Emitter <SettleupState> emit) async{

      try{
        final res = await authStorage.retrieveData();
        final userId = res["user_id"];

        print("in settlement bloc $userId");

        if (userId != null) {

          final settleTrans = await expenseDetails.SettleLoggedinUserTransactions(event.trans_id, event.user_id );
          print("from settlement transaction $settleTrans");
          if(settleTrans["status"] == 200){
            final st = state;
            emit(MakeSettlementSuccess(response: res));
            emit(st);
          }

        }
        else{
          emit(MakeSettlementFailure(message : res["message"]));
        }

      }
      catch(err){
        emit(MakeSettlementFailure(message: '$err'));
      }



    });
  }
}
