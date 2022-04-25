import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw/screen/splash/splash_event.dart';
import 'package:maw/screen/splash/splash_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/network/services/network_factory.dart';
import '../../utils/const.dart';


class SplashBloc extends Bloc<SplashEvent,SplashState>{
  NetWorkFactory? _networkFactory;
  BuildContext? context;
  String? _accessToken;
  String? _refreshToken;
  SharedPreferences? _prefs;

  @override
  SplashBloc(this.context) : super(SplashInitial()) {
    _networkFactory = NetWorkFactory(context!);
  }

  SplashState get initialState => SplashInitial();

  Stream<SplashState> mapEventToState(SplashEvent event)async* {
    // TODO: implement mapEventToState
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
      _accessToken = _prefs!.getString(Const.ACCESS_TOKEN) ?? "";
      _refreshToken = _prefs!.getString(Const.REFRESH_TOKEN) ?? "";
    }

    // if(event is GetListNotificationSplashEvent){
    //   yield SplashLoading();
    //   SplashState state = _handleGetListNotification(await _networkFactory.getListNotification(_accessToken,1,1));
    //   yield state;
    // }
  }

  // SplashState _handleGetListNotification(Object data){
  //   if(data is String) return GetListNotificationSplashFailure("Error".tr);
  //   try{
  //     return GetListNotificationSplashSuccess();
  //   }catch(e){
  //     print(e.toString());
  //     return GetListNotificationSplashFailure(e.toString().tr);
  //   }
  // }
}