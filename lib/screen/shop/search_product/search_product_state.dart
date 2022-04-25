import 'package:equatable/equatable.dart';

abstract class SearchProductState extends Equatable {
  @override
  List<Object> get props => [];
}
class InitialSearchProductState extends SearchProductState {

  @override
  String toString() {
    return 'InitialSearchProductState{}';
  }
}

class GetPrefsSuccess extends SearchProductState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}

class SearchProductLoading extends SearchProductState {

  @override
  String toString() => 'SearchProductLoading';
}
