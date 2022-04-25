import 'package:equatable/equatable.dart';

abstract class ContributorState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialContributorState extends ContributorState {

  @override
  String toString() {
    return 'InitialContributorState{}';
  }
}