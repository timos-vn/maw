import 'package:equatable/equatable.dart';

abstract class MapEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends MapEvent {
  @override
  String toString() => 'GetPrefs';
}

class GetListWaterFactory extends MapEvent{
  @override
  String toString() => 'GetListWaterFactory';
}

class GetListWaterTestingCenter extends MapEvent{
  @override
  String toString() => 'GetListWaterTestingCenter';
}