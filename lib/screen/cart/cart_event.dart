import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends CartEvent {
  @override
  String toString() => 'GetPrefs';
}
