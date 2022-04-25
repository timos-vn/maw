import 'package:equatable/equatable.dart';

abstract class HistoryDeviceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends HistoryDeviceEvent {
  @override
  String toString() => 'GetPrefs';
}
