import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/const.dart';
import 'detail_product_state.dart';
import 'detail_product_event.dart';

class DetailProductBloc extends Bloc<DetailProductEvent,DetailProductState>{

  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;
  int indexBanner = 0;
  List<String> listTabView = ["Mô tả sản phẩm", "Đánh giá & Nhận xét"];

  DetailProductBloc() : super(InitialDetailProductState()){
    on<GetPrefs>(_getPrefs);
    on<IndexBanner>(_indexNextVoucher);
  }

  void _getPrefs(GetPrefs event, Emitter<DetailProductState> emitter)async{
    emitter(InitialDetailProductState());
    _pref = await SharedPreferences.getInstance();
    userName = _pref!.getString(Const.USER_NAME) ?? "";
    _accessToken = _pref!.getString(Const.ACCESS_TOKEN) ?? "";
    _refreshToken = _pref!.getString(Const.REFRESH_TOKEN) ?? "";
    emitter(GetPrefsSuccess());
  }

  void _indexNextVoucher(IndexBanner event, Emitter<DetailProductState> emitter){
    emitter(DetailProductLoading());
    indexBanner = event.indexBanner!;
    emitter(InitialDetailProductState());
  }
}