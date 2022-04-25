
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'point_event.dart';
import 'point_state.dart';

class PointBloc extends Bloc<PointEvent,PointState>{

  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;
  int checkingBonus = 0;

  PointBloc() : super(InitialPointState()){
    on<CheckingTimeSchedule>(_checkingTimeSchedule);
  }

  void _checkingTimeSchedule(CheckingTimeSchedule event, Emitter<PointState> emitter){
    emitter(InitialPointState());
    checkingBonus = event.valueBonus;
    emitter(CheckingTimeScheduleSuccess());
  }
}