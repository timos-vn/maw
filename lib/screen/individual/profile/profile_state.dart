import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialProfileState extends ProfileState {

  @override
  String toString() {
    return 'InitialProfileState{}';
  }
}