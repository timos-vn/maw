import 'package:equatable/equatable.dart';

abstract class ExpertLibEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends ExpertLibEvent {
  @override
  String toString() => 'GetPrefs';
}

class CheckingBonus extends ExpertLibEvent {

  final int valueBonus;

  CheckingBonus(this.valueBonus);

  @override
  String toString() => 'CheckingBonus{valueBonus:$valueBonus}';
}

class CheckingTimeSchedule extends ExpertLibEvent {

  final int valueBonus;

  CheckingTimeSchedule(this.valueBonus);

  @override
  String toString() => 'CheckingTimeSchedule{valueBonus:$valueBonus}';
}