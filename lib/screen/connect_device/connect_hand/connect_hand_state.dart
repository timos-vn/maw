import 'package:equatable/equatable.dart';

abstract class ConnectHandState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialConnectHandState extends ConnectHandState {

  @override
  String toString() {
    return 'InitialConnectHandState{}';
  }
}

class GetPrefsSuccess extends ConnectHandState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}

class AddOrRemoveCoreWaterSuccess extends ConnectHandState{

  @override
  String toString() {
    return 'AddOrRemoveCoreWaterSuccess{}';
  }
}