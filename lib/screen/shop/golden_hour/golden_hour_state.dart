import 'package:equatable/equatable.dart';

abstract class GoldenHourState extends Equatable {
  @override
  List<Object> get props => [];
}
class InitialGoldenHourState extends GoldenHourState {

  @override
  String toString() {
    return 'InitialGoldenHourState{}';
  }
}

class GetPrefsSuccess extends GoldenHourState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}