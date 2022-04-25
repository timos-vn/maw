import 'package:equatable/equatable.dart';

abstract class TicketState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialTicketState extends TicketState {

  @override
  String toString() {
    return 'InitialTicketState{}';
  }
}