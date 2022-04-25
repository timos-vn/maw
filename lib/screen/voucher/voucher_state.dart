import 'package:equatable/equatable.dart';

abstract class VoucherState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialVoucherState extends VoucherState {

  @override
  String toString() {
    return 'InitialVoucherState{}';
  }
}

class ChangePageViewSuccess extends VoucherState{

  final int valueChange;

  ChangePageViewSuccess(this.valueChange);

  @override
  String toString() {
    return 'ChangePageViewSuccess{valueChange:$valueChange}';
  }
}


class CheckingStoreSuccess extends VoucherState{

  @override
  String toString() {
    return 'CheckingStoreSuccess{}';
  }
}