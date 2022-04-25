import 'package:equatable/equatable.dart';

abstract class ConnectWifiEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends ConnectWifiEvent {
  @override
  String toString() => 'GetPrefs';
}