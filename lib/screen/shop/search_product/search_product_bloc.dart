import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw/screen/shop/search_product/search_product_event.dart';
import 'package:maw/screen/shop/search_product/search_product_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/const.dart';

class SearchProductBloc extends Bloc<SearchProductEvent,SearchProductState>{

  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;


  SearchProductBloc() : super(InitialSearchProductState()){
    on<GetPrefs>(_getPrefs);
  }

  void _getPrefs(GetPrefs event, Emitter<SearchProductState> emitter)async{
    emitter(InitialSearchProductState());
    _pref = await SharedPreferences.getInstance();
    userName = _pref!.getString(Const.USER_NAME) ?? "";
    _accessToken = _pref!.getString(Const.ACCESS_TOKEN) ?? "";
    _refreshToken = _pref!.getString(Const.REFRESH_TOKEN) ?? "";
    emitter(GetPrefsSuccess());
  }
}