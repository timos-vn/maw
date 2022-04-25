import 'package:equatable/equatable.dart';

abstract class OrderForSomeOneEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends OrderForSomeOneEvent {
  @override
  String toString() => 'GetPrefs';
}

class CheckingBonus extends OrderForSomeOneEvent {

  final int valueBonus;

  CheckingBonus(this.valueBonus);

  @override
  String toString() => 'CheckingBonus{valueBonus:$valueBonus}';
}