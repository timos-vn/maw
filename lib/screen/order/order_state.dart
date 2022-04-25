import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialOrderState extends OrderState {

  @override
  String toString() {
    return 'InitialOrderState{}';
  }
}