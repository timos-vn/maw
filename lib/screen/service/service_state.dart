import 'package:equatable/equatable.dart';

abstract class ServiceState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialServiceState extends ServiceState {

  @override
  String toString() {
    return 'InitialServiceState{}';
  }
}

class ChangePageViewSuccess extends ServiceState{

  final int valueChange;

  ChangePageViewSuccess(this.valueChange);

  @override
  String toString() {
    return 'ChangePageViewSuccess{valueChange:$valueChange}';
  }
}


class CheckingStoreSuccess extends ServiceState{

  @override
  String toString() {
    return 'CheckingStoreSuccess{}';
  }
}