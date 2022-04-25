
import 'package:flutter_bloc/flutter_bloc.dart';

import 'people_event.dart';
import 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent,PeopleState>{

  PeopleBloc() : super(InitialPeopleState()){
    print('InitialTicketState');
  }
}