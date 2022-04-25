import 'package:equatable/equatable.dart';

abstract class PersonalState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialPersonalState extends PersonalState {

  @override
  String toString() {
    return 'InitialPersonalState{}';
  }
}