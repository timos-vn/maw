import 'package:equatable/equatable.dart';

abstract class ShopEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends ShopEvent {
  @override
  String toString() => 'GetPrefs';
}