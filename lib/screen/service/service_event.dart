import 'package:equatable/equatable.dart';

abstract class ServiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangePageViewEvent extends ServiceEvent {

  final int valueChange;

  ChangePageViewEvent(this.valueChange);

  @override
  String toString() => 'ChangePageViewEvent{valueChange:$valueChange}';
}