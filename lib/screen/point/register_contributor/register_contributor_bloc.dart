
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_contributor_event.dart';
import 'register_contributor_state.dart';

class RegisterContributorBloc extends Bloc<RegisterContributorEvent,RegisterContributorState>{
  RegisterContributorBloc() : super(InitialRegisterContributorState()){
    print('InitialRegisterContributorState');
  }
}