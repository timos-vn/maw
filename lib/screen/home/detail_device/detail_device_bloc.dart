import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/const.dart';
import 'detail_device_event.dart';
import 'detail_device_state.dart';

class DetailDeviceBloc extends Bloc<DetailDeviceEvent,DetailDeviceState>{

  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;
  int indexBanner = 0;

  DetailDeviceBloc() : super(InitialDetailDeviceState()){
    on<GetPrefs>(_getPrefs);
    on<IndexBanner>(_indexNextVoucher);
  }

  void _getPrefs(GetPrefs event, Emitter<DetailDeviceState> emitter)async{
    emitter(InitialDetailDeviceState());
    _pref = await SharedPreferences.getInstance();
    userName = _pref!.getString(Const.USER_NAME) ?? "";
    _accessToken = _pref!.getString(Const.ACCESS_TOKEN) ?? "";
    _refreshToken = _pref!.getString(Const.REFRESH_TOKEN) ?? "";
    emitter(GetPrefsSuccess());
  }

  void _indexNextVoucher(IndexBanner event, Emitter<DetailDeviceState> emitter){
    emitter(DetailDeviceLoading());
    indexBanner = event.indexBanner!;
    emitter(InitialDetailDeviceState());
  }
}