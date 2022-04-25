import 'package:equatable/equatable.dart';

abstract class VoucherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangePageViewEvent extends VoucherEvent {

  final int valueChange;

  ChangePageViewEvent(this.valueChange);

  @override
  String toString() => 'ChangePageViewEvent{valueChange:$valueChange}';
}