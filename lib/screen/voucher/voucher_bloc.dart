import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'voucher_event.dart';
import 'voucher_state.dart';

class VoucherBloc extends Bloc<VoucherEvent,VoucherState>{

  List<String> listTabVoucher = ["Đang sự dụng", "Chưa sử dụng",'Hết hạn'];
  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;
  int valueChange = 0;
  int checkingStore = 0;

  VoucherBloc() : super(InitialVoucherState()){
    on<ChangePageViewEvent>(_changePageView);
  }

  void _changePageView(ChangePageViewEvent event, Emitter<VoucherState> emitter){
    emitter(InitialVoucherState());
    valueChange = event.valueChange;
    checkingStore = event.valueChange;
    emitter(ChangePageViewSuccess(valueChange));
  }

}