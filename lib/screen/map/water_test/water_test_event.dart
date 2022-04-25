import 'package:equatable/equatable.dart';

abstract class WaterTestEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends WaterTestEvent {
  @override
  String toString() => 'GetPrefs';
}

class CheckingBonus extends WaterTestEvent {

  final int valueBonus;

  CheckingBonus(this.valueBonus);

  @override
  String toString() => 'CheckingBonus{valueBonus:$valueBonus}';
}

class CheckingTimeSchedule extends WaterTestEvent {

  final int valueBonus;

  CheckingTimeSchedule(this.valueBonus);

  @override
  String toString() => 'CheckingTimeSchedule{valueBonus:$valueBonus}';
}