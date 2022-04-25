import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/const.dart';
import 'order_for_someone_event.dart';
import 'order_for_someone_state.dart';

class OrderForSomeOneBloc extends Bloc<OrderForSomeOneEvent,OrderForSomeOneState>{

  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;
  int checkingBonus = 0;

  OrderForSomeOneBloc() : super(InitialOrderForSomeOneState()){
    on<GetPrefs>(_getPrefs);
    on<CheckingBonus>(_checkingBonus);
  }

  void _getPrefs(GetPrefs event, Emitter<OrderForSomeOneState> emitter)async{
    emitter(InitialOrderForSomeOneState());
    _pref = await SharedPreferences.getInstance();
    userName = _pref!.getString(Const.USER_NAME) ?? "";
    _accessToken = _pref!.getString(Const.ACCESS_TOKEN) ?? "";
    _refreshToken = _pref!.getString(Const.REFRESH_TOKEN) ?? "";
    emitter(GetPrefsSuccess());
  }

  void _checkingBonus(CheckingBonus event, Emitter<OrderForSomeOneState> emitter){
    emitter(InitialOrderForSomeOneState());
    checkingBonus = event.valueBonus;
    emitter(CheckingBonusSuccess());
  }
}