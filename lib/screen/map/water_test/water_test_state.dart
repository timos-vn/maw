import 'package:equatable/equatable.dart';

abstract class WaterTestState extends Equatable {
  @override
  List<Object> get props => [];
}
class InitialWaterTestState extends WaterTestState {

  @override
  String toString() {
    return 'InitialWaterTestState{}';
  }
}

class GetPrefsSuccess extends WaterTestState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}

class CheckingBonusSuccess extends WaterTestState{

  @override
  String toString() {
    return 'CheckingBonusSuccess{}';
  }
}

class CheckingTimeScheduleSuccess extends WaterTestState{

  @override
  String toString() {
    return 'CheckingTimeScheduleSuccess{}';
  }
}