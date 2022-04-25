import 'package:equatable/equatable.dart';

abstract class PointEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckingTimeSchedule extends PointEvent {

  final int valueBonus;

  CheckingTimeSchedule(this.valueBonus);

  @override
  String toString() => 'CheckingTimeSchedule{valueBonus:$valueBonus}';
}