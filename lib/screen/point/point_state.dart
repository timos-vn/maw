import 'package:equatable/equatable.dart';

abstract class PointState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialPointState extends PointState {

  @override
  String toString() {
    return 'InitialPointState{}';
  }
}

class CheckingTimeScheduleSuccess extends PointState{

  @override
  String toString() {
    return 'CheckingTimeScheduleSuccess{}';
  }
}