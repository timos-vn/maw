
import 'package:flutter_bloc/flutter_bloc.dart';

import 'personal_event.dart';
import 'personal_state.dart';

class PersonalBloc extends Bloc<PersonalEvent,PersonalState>{

  PersonalBloc() : super(InitialPersonalState()){
    print('InitialTicketState');
  }
}