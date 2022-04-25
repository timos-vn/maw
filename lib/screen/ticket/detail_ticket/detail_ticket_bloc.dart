
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail_ticket_event.dart';
import 'detail_ticket_state.dart';

class DetailTicketBloc extends Bloc<DetailTicketEvent,DetailTicketState>{

  DetailTicketBloc() : super(InitialDetailTicketState()){
    print('InitialTicketState');
  }
}