import 'package:equatable/equatable.dart';

abstract class GoldenHourEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends GoldenHourEvent {
  @override
  String toString() => 'GetPrefs';
}