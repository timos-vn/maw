import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/const.dart';
import 'history_device_event.dart';
import 'history_device_state.dart';


class HistoryDeviceBloc extends Bloc<HistoryDeviceEvent,HistoryDeviceState>{

  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;

  HistoryDeviceBloc() : super(InitialHistoryDeviceState()){
    on<GetPrefs>(_getPrefs);
  }

  void _getPrefs(GetPrefs event, Emitter<HistoryDeviceState> emitter)async{
    emitter(InitialHistoryDeviceState());
    _pref = await SharedPreferences.getInstance();
    userName = _pref!.getString(Const.USER_NAME) ?? "";
    _accessToken = _pref!.getString(Const.ACCESS_TOKEN) ?? "";
    _refreshToken = _pref!.getString(Const.REFRESH_TOKEN) ?? "";
    emitter(GetPrefsSuccess());
  }

}