import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw/screen/shop/shop_event.dart';
import 'package:maw/screen/shop/shop_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/const.dart';

class ShopBloc extends Bloc<ShopEvent,ShopState>{

  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;

  ShopBloc() : super(InitialShopState()){
    on<GetPrefs>(_getPrefs);
  }

  void _getPrefs(GetPrefs event, Emitter<ShopState> emitter)async{
    emitter(InitialShopState());
    _pref = await SharedPreferences.getInstance();
    userName = _pref!.getString(Const.USER_NAME) ?? "";
    _accessToken = _pref!.getString(Const.ACCESS_TOKEN) ?? "";
    _refreshToken = _pref!.getString(Const.REFRESH_TOKEN) ?? "";
    emitter(GetPrefsSuccess());
  }
}