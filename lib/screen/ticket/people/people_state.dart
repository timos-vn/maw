import 'package:equatable/equatable.dart';

abstract class PeopleState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialPeopleState extends PeopleState {

  @override
  String toString() {
    return 'InitialPeopleState{}';
  }
}