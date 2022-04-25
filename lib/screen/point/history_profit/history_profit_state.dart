import 'package:equatable/equatable.dart';

abstract class HistoryProfitState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialHistoryProfitState extends HistoryProfitState {

  @override
  String toString() {
    return 'InitialHistoryProfitState{}';
  }
}

class ChangePageViewSuccess extends HistoryProfitState{

  final int valueChange;

  ChangePageViewSuccess(this.valueChange);

  @override
  String toString() {
    return 'ChangePageViewSuccess{valueChange:$valueChange}';
  }
}