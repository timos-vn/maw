import 'package:maw/utils/const.dart';

class HostSingleton {
  String host = Const.HOST_URL;
  int port = Const.PORT_URL;

  static final HostSingleton _singleton = HostSingleton._internal();

  factory HostSingleton() {
    return _singleton;
  }

  HostSingleton._internal();

  void showError(){
  }
}