import 'package:equatable/equatable.dart';

abstract class HistoryPointState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialHistoryPointState extends HistoryPointState {

  @override
  String toString() {
    return 'InitialHistoryPointState{}';
  }
}

class ChangePageViewSuccess extends HistoryPointState{

  final int valueChange;

  ChangePageViewSuccess(this.valueChange);

  @override
  String toString() {
    return 'ChangePageViewSuccess{valueChange:$valueChange}';
  }
}