import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/const.dart';
import 'expert_lib_event.dart';
import 'expert_lib_state.dart';

class ExpertLibBloc extends Bloc<ExpertLibEvent,ExpertLibState>{

  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;
  int checkingBonus = 0;

  ExpertLibBloc() : super(InitialExpertLibState()){
    on<GetPrefs>(_getPrefs);
    on<CheckingBonus>(_checkingBonus);
    on<CheckingTimeSchedule>(_checkingTimeSchedule);
  }

  void _getPrefs(GetPrefs event, Emitter<ExpertLibState> emitter)async{
    emitter(InitialExpertLibState());
    _pref = await SharedPreferences.getInstance();
    userName = _pref!.getString(Const.USER_NAME) ?? "";
    _accessToken = _pref!.getString(Const.ACCESS_TOKEN) ?? "";
    _refreshToken = _pref!.getString(Const.REFRESH_TOKEN) ?? "";
    emitter(GetPrefsSuccess());
  }

  void _checkingBonus(CheckingBonus event, Emitter<ExpertLibState> emitter){
    emitter(InitialExpertLibState());
    checkingBonus = event.valueBonus;
    emitter(CheckingBonusSuccess());
  }

  void _checkingTimeSchedule(CheckingTimeSchedule event, Emitter<ExpertLibState> emitter){
    emitter(InitialExpertLibState());
    checkingBonus = event.valueBonus;
    emitter(CheckingTimeScheduleSuccess());
  }
}