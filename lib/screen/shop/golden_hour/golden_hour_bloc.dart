import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/const.dart';
import 'golden_hour_event.dart';
import 'golden_hour_state.dart';

class GoldenHourBloc extends Bloc<GoldenHourEvent,GoldenHourState>{

  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;
  List<String> listTabViewSale = ["Sản phẩm", "Gói xét nghiệm", "Dịch vụ"];

  GoldenHourBloc() : super(InitialGoldenHourState()){
    on<GetPrefs>(_getPrefs);
  }

  void _getPrefs(GoldenHourEvent event, Emitter<GoldenHourState> emitter)async{
    emitter(InitialGoldenHourState());
    _pref = await SharedPreferences.getInstance();
    userName = _pref!.getString(Const.USER_NAME) ?? "";
    _accessToken = _pref!.getString(Const.ACCESS_TOKEN) ?? "";
    _refreshToken = _pref!.getString(Const.REFRESH_TOKEN) ?? "";
    emitter(GetPrefsSuccess());
  }
}