import 'package:bloc/bloc.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/expense_service/expense_details.dart';
import 'package:meta/meta.dart';
import './view_settlement_event.dart';
import './view_settlement_state.dart';

class ViewSettlementBloc extends Bloc<ViewSettlementEvent, ViewSettlementState> {
  final AuthStorage authStorage;
  final ExpenseDetails expenseDetails;

  ViewSettlementBloc({required this.authStorage, required this.expenseDetails}) : super(ViewSettlementInitial()) {
    on<ViewSettlementEvent>((event, emit) {});

    on<GetAllSettlementsEvent>((GetAllSettlementsEvent event, Emitter <ViewSettlementState> emit) async{

      try{
        final userDetail = await authStorage.retrieveData();

        final res = await expenseDetails.GetAllSettlementRecord(userDetail["user_id"].toString());

        print(userDetail);
        print("from bloc file $res");
        print("the status is ${res['status']}");
        if(res['status'] == 200){
          emit(AllSettlementSuccess(allData: res, userData : userDetail));
        }
        else{
          emit(AllSettlementFailure(message: '${res['message']}'));
        }
      }catch(err){
        emit(AllSettlementFailure(message: '$err'));

      }


    });



  }
}
