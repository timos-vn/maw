
import 'package:flutter_bloc/flutter_bloc.dart';

import 'membership_event.dart';
import 'membership_state.dart';

class MembershipBloc extends Bloc<MembershipEvent,MembershipState>{
  MembershipBloc() : super(InitialMembershipState()){
    print('InitialPointState');
  }
}