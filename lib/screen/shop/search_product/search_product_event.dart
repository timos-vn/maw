import 'package:equatable/equatable.dart';

abstract class SearchProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends SearchProductEvent {
  @override
  String toString() => 'GetPrefs';
}
