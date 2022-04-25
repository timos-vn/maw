import 'package:equatable/equatable.dart';

abstract class OrderForSomeOneState extends Equatable {
  @override
  List<Object> get props => [];
}
class InitialOrderForSomeOneState extends OrderForSomeOneState {

  @override
  String toString() {
    return 'InitialOrderForSomeOneState{}';
  }
}

class GetPrefsSuccess extends OrderForSomeOneState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}

class CheckingBonusSuccess extends OrderForSomeOneState{

  @override
  String toString() {
    return 'CheckingBonusSuccess{}';
  }
}