import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialHomeState extends HomeState {

  @override
  String toString() {
    return 'InitialHomeState{}';
  }
}

class GetPrefsSuccess extends HomeState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}

class HomeLoading extends HomeState {

  @override
  String toString() => 'HomeLoading';
}
