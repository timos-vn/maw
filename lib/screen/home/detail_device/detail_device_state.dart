import 'package:equatable/equatable.dart';

abstract class DetailDeviceState extends Equatable {
  @override
  List<Object> get props => [];
}
class InitialDetailDeviceState extends DetailDeviceState {

  @override
  String toString() {
    return 'InitialDetailDeviceState{}';
  }
}

class GetPrefsSuccess extends DetailDeviceState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}

class DetailDeviceLoading extends DetailDeviceState {

  @override
  String toString() => 'DetailDeviceLoading';
}
