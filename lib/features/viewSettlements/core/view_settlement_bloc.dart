import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'view_settlement_event.dart';
part 'view_settlement_state.dart';

class ViewSettlementBloc extends Bloc<ViewSettlementEvent, ViewSettlementState> {
  ViewSettlementBloc() : super(ViewSettlementInitial()) {
    on<ViewSettlementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
