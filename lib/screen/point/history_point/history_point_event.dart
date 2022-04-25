import 'package:equatable/equatable.dart';

abstract class HistoryPointEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangePageViewEvent extends HistoryPointEvent {

  final int valueChange;

  ChangePageViewEvent(this.valueChange);

  @override
  String toString() => 'ChangePageViewEvent{valueChange:$valueChange}';
}