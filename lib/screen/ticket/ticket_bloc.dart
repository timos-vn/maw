
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ticket_event.dart';
import 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent,TicketState>{

  List<String> listTabViewTicket = ["Cá nhân", "Mọi người",];

  TicketBloc() : super(InitialTicketState()){
    print('InitialTicketState');
  }
}