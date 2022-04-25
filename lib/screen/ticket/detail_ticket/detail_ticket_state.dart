import 'package:equatable/equatable.dart';

abstract class DetailTicketState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialDetailTicketState extends DetailTicketState {

  @override
  String toString() {
    return 'InitialDetailTicketState{}';
  }
}