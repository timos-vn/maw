import 'package:equatable/equatable.dart';

abstract class ExpertLibState extends Equatable {
  @override
  List<Object> get props => [];
}
class InitialExpertLibState extends ExpertLibState {

  @override
  String toString() {
    return 'InitialWaterTestState{}';
  }
}

class GetPrefsSuccess extends ExpertLibState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}

class CheckingBonusSuccess extends ExpertLibState{

  @override
  String toString() {
    return 'CheckingBonusSuccess{}';
  }
}

class CheckingTimeScheduleSuccess extends ExpertLibState{

  @override
  String toString() {
    return 'CheckingTimeScheduleSuccess{}';
  }
}