import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/const.dart';
import 'history_report_event.dart';
import 'history_report_state.dart';


class HistoryReportBloc extends Bloc<HistoryReportEvent,HistoryReportState>{

  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;

  HistoryReportBloc() : super(InitialHistoryReportState()){
    on<GetPrefs>(_getPrefs);
  }

  void _getPrefs(GetPrefs event, Emitter<HistoryReportState> emitter)async{
    emitter(InitialHistoryReportState());
    _pref = await SharedPreferences.getInstance();
    userName = _pref!.getString(Const.USER_NAME) ?? "";
    _accessToken = _pref!.getString(Const.ACCESS_TOKEN) ?? "";
    _refreshToken = _pref!.getString(Const.REFRESH_TOKEN) ?? "";
    emitter(GetPrefsSuccess());
  }

}