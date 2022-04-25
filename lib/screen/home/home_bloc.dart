import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/const.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{

  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;
  int indexBanner = 0;

  HomeBloc() : super(InitialHomeState()){
    on<GetPrefs>(_getPrefs);
    on<IndexBanner>(_indexNextVoucher);
  }


  void _getPrefs(GetPrefs event, Emitter<HomeState> emitter)async{
    emitter(InitialHomeState());
    _pref = await SharedPreferences.getInstance();
    userName = _pref!.getString(Const.USER_NAME) ?? "";
    _accessToken = _pref!.getString(Const.ACCESS_TOKEN) ?? "";
    _refreshToken = _pref!.getString(Const.REFRESH_TOKEN) ?? "";
    emitter(GetPrefsSuccess());
  }

  void _indexNextVoucher(IndexBanner event, Emitter<HomeState> emitter){
    emitter(HomeLoading());
    indexBanner = event.indexBanner!;
    emitter(InitialHomeState());
  }
}