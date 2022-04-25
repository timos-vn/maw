
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'history_profit_event.dart';
import 'history_profit_state.dart';

class HistoryProfitBloc extends Bloc<HistoryProfitEvent,HistoryProfitState>{

  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;
  int valueChange = 0;
  List<String> listTabViewHistory = ["Tất cả", "Giới thiệu",'Thụ động'];

  HistoryProfitBloc() : super(InitialHistoryProfitState()){
    on<ChangePageViewEvent>(_changePageView);
  }

  void _changePageView(ChangePageViewEvent event, Emitter<HistoryProfitState> emitter){
    emitter(InitialHistoryProfitState());
    valueChange = event.valueChange;
    emitter(ChangePageViewSuccess(valueChange));
  }
}