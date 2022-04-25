
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'history_point_event.dart';
import 'history_point_state.dart';

class HistoryPointBloc extends Bloc<HistoryPointEvent,HistoryPointState>{

  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;
  int valueChange = 0;
  List<String> listTabViewHistory = ["Tất cả", "Mua hàng",'Giới thiệu'];

  HistoryPointBloc() : super(InitialHistoryPointState()){
    on<ChangePageViewEvent>(_changePageView);
  }

  void _changePageView(ChangePageViewEvent event, Emitter<HistoryPointState> emitter){
    emitter(InitialHistoryPointState());
    valueChange = event.valueChange;
    emitter(ChangePageViewSuccess(valueChange));
  }
}