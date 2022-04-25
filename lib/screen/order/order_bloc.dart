
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent,OrderState>{

  List<String> listTabViewProfile = ["Xác nhận", "Đang thực hiện",'Đã thực hiện',"Huỷ"];

  OrderBloc() : super(InitialOrderState()){
    print('InitialIndividualState');
  }
}