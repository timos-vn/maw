import 'package:equatable/equatable.dart';

abstract class UpdateHistoryDeviceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends UpdateHistoryDeviceEvent {
  @override
  String toString() => 'GetPrefs';
}
