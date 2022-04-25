import 'package:equatable/equatable.dart';

abstract class SalesState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialSalesState extends SalesState {

  @override
  String toString() {
    return 'InitialSalesState{}';
  }
}