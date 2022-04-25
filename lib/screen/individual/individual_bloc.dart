
import 'package:flutter_bloc/flutter_bloc.dart';

import 'individual_event.dart';
import 'individual_state.dart';

class IndividualBloc extends Bloc<IndividualEvent,IndividualState>{
  IndividualBloc() : super(InitialIndividualState()){
    print('InitialIndividualState');
  }
}