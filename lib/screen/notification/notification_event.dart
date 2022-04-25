import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefs extends NotificationEvent {
  @override
  String toString() => 'GetPrefs';
}
