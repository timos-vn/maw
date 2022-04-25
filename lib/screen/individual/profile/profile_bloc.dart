
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{

  List<String> listTabViewProfile = ["Thông tin", "Điểm",'Người liên hệ'];
  List<IconData> listIcon = [MdiIcons.accountDetails,MdiIcons.crown,MdiIcons.accountMultiplePlus];

  ProfileBloc() : super(InitialProfileState()){
    // ignore: avoid_print
    print('InitialIndividualState');
  }
}