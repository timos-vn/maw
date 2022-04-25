import 'package:equatable/equatable.dart';

abstract class RegisterContributorState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialRegisterContributorState extends RegisterContributorState {

  @override
  String toString() {
    return 'InitialRegisterContributorState{}';
  }
}