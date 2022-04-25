
import 'package:flutter_bloc/flutter_bloc.dart';

import 'contributor_event.dart';
import 'contributor_state.dart';

class ContributorBloc extends Bloc<ContributorEvent,ContributorState>{
  ContributorBloc() : super(InitialContributorState()){
    print('InitialPointState');
  }
}