import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}
class InitialCartState extends CartState {

  @override
  String toString() {
    return 'InitialCartState{}';
  }
}

class GetPrefsSuccess extends CartState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}

