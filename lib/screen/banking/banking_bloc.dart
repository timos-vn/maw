
import 'package:flutter_bloc/flutter_bloc.dart';

import 'banking_event.dart';
import 'banking_state.dart';

class BankingBloc extends Bloc<BankingEvent,BankingState>{
  BankingBloc() : super(InitialBankingState()){
    print('InitialBankingState');
  }
}