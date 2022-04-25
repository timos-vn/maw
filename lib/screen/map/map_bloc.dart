import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/network/services/network_factory.dart';
import '../../utils/const.dart';
import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent,MapState>{
  BuildContext context;
  NetWorkFactory? _networkFactory;
  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;

  MapBloc(this.context) : super(InitialMapState()){
    _networkFactory = NetWorkFactory(context);
    on<GetPrefs>(_getPrefs);
  }

  void _getPrefs(GetPrefs event, Emitter<MapState> emitter)async{
    emitter(InitialMapState());
    _pref = await SharedPreferences.getInstance();
    userName = _pref!.getString(Const.USER_NAME) ?? "";
    _accessToken = _pref!.getString(Const.ACCESS_TOKEN) ?? "";
    _refreshToken = _pref!.getString(Const.REFRESH_TOKEN) ?? "";
    emitter(GetPrefsSuccess());
  }

  void _getListWaterFactory(GetListWaterFactory event,Emitter<MapState> emitter)async{
    emitter(MapLoading());
   // MapState state = handleGetListWaterFactory(await _networkFactory);
  }
}