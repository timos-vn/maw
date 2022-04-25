import 'package:equatable/equatable.dart';

abstract class ConnectWifiState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialConnectWifiState extends ConnectWifiState {

  @override
  String toString() {
    return 'InitialConnectWifiState{}';
  }
}

class GetPrefsSuccess extends ConnectWifiState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}