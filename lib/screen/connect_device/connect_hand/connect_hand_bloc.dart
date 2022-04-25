import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw/models/models/core_water.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/const.dart';
import 'connect_hand_event.dart';
import 'connect_hand_state.dart';

class ConnectHandBloc extends Bloc<ConnectHandEvent,ConnectHandState>{

  SharedPreferences? _pref;
  SharedPreferences? get pref => _pref;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;
  late List<DataCoreWater> listCoreWater = [];

  ConnectHandBloc() : super(InitialConnectHandState()){
    on<GetPrefs>(_getPrefs);
    on<AddOrRemoveCoreWater>(_addOrRemoveCoreWater);
  }

  void _getPrefs(GetPrefs event, Emitter<ConnectHandState> emitter)async{
    emitter(InitialConnectHandState());
    _pref = await SharedPreferences.getInstance();
    userName = _pref!.getString(Const.USER_NAME) ?? "";
    _accessToken = _pref!.getString(Const.ACCESS_TOKEN) ?? "";
    _refreshToken = _pref!.getString(Const.REFRESH_TOKEN) ?? "";
    emitter(GetPrefsSuccess());
  }

  void _addOrRemoveCoreWater(AddOrRemoveCoreWater event,Emitter<ConnectHandState> emitter){
    emitter(InitialConnectHandState());
    if(event.type == true){
      //add
      listCoreWater.add(event.item);
    }else{
      //remove
      if(listCoreWater.isNotEmpty){
        listCoreWater.removeAt(event.index!);
      }
    }
    emitter(AddOrRemoveCoreWaterSuccess());
  }
}