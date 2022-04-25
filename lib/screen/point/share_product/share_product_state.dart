import 'package:equatable/equatable.dart';

abstract class ShareProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialShareProductState extends ShareProductState {

  @override
  String toString() {
    return 'InitialShareProductState{}';
  }
}