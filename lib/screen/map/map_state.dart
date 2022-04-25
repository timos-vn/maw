import 'package:equatable/equatable.dart';

abstract class MapState extends Equatable {
  @override
  List<Object> get props => [];
}
class InitialMapState extends MapState {

  @override
  String toString() {
    return 'InitialMapState{}';
  }
}

class GetPrefsSuccess extends MapState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}

class MapLoading extends MapState{

  @override
  String toString() {
    return 'MapLoading{}';
  }
}

class MapFailure extends MapState {
  final String error;

  MapFailure(this.error);

  @override
  String toString() => 'MapFailure { error: $error }';
}

class MapSuccess extends MapState{

  @override
  String toString() {
    return 'MapSuccess{}';
  }
}