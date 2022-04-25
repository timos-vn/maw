import 'package:equatable/equatable.dart';

abstract class UpdateHistoryDeviceState extends Equatable {
  @override
  List<Object> get props => [];
}
class InitialUpdateHistoryDeviceState extends UpdateHistoryDeviceState {

  @override
  String toString() {
    return 'InitialUpdateHistoryDeviceState{}';
  }
}

class GetPrefsSuccess extends UpdateHistoryDeviceState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}

class UpdateHistoryDeviceLoading extends UpdateHistoryDeviceState {

  @override
  String toString() => 'UpdateHistoryDeviceLoading';
}
