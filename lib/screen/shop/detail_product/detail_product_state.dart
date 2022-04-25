import 'package:equatable/equatable.dart';

abstract class DetailProductState extends Equatable {
  @override
  List<Object> get props => [];
}
class InitialDetailProductState extends DetailProductState {

  @override
  String toString() {
    return 'InitialDetailProductState{}';
  }
}

class GetPrefsSuccess extends DetailProductState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}

class DetailProductLoading extends DetailProductState {

  @override
  String toString() => 'DetailProductLoading';
}
