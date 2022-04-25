import 'package:equatable/equatable.dart';

abstract class HistoryDeviceState extends Equatable {
  @override
  List<Object> get props => [];
}
class InitialHistoryDeviceState extends HistoryDeviceState {

  @override
  String toString() {
    return 'InitialHistoryDeviceState{}';
  }
}

class GetPrefsSuccess extends HistoryDeviceState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}

class HistoryDeviceLoading extends HistoryDeviceState {

  @override
  String toString() => 'HistoryDeviceLoading';
}
