
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sales_event.dart';
import 'sales_state.dart';

class SalesBloc extends Bloc<SalesEvent,SalesState>{
  SalesBloc() : super(InitialSalesState()){
    print('InitialSalesState');
  }
}