import 'package:equatable/equatable.dart';

abstract class IndividualState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialIndividualState extends IndividualState {

  @override
  String toString() {
    return 'InitialIndividualState{}';
  }
}