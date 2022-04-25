import 'package:equatable/equatable.dart';

abstract class ShareAppState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialShareAppState extends ShareAppState {

  @override
  String toString() {
    return 'InitialShareAppState{}';
  }
}