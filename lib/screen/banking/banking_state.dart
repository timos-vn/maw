import 'package:equatable/equatable.dart';

abstract class BankingState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialBankingState extends BankingState {

  @override
  String toString() {
    return 'InitialBankingState{}';
  }
}