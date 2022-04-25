
import 'package:flutter_bloc/flutter_bloc.dart';

import 'share_app_event.dart';
import 'share_app_state.dart';

class ShareAppBloc extends Bloc<ShareAppEvent,ShareAppState>{
  ShareAppBloc() : super(InitialShareAppState()){
    print('InitialShareAppState');
  }
}