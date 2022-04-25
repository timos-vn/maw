import 'package:equatable/equatable.dart';

abstract class HistoryProfitEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangePageViewEvent extends HistoryProfitEvent {

  final int valueChange;

  ChangePageViewEvent(this.valueChange);

  @override
  String toString() => 'ChangePageViewEvent{valueChange:$valueChange}';
}