
import 'package:flutter_bloc/flutter_bloc.dart';

import 'share_product_event.dart';
import 'share_product_state.dart';

class ShareProductBloc extends Bloc<ShareProductEvent,ShareProductState>{

  List<String> listTabViewProduct = ["Đã thành công (01)", "Đang thực hiện (01)",];

  ShareProductBloc() : super(InitialShareProductState()){
    print('InitialShareProductState');
  }
}