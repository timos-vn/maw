import 'package:equatable/equatable.dart';

abstract class NotificationState extends Equatable {
  @override
  List<Object> get props => [];
}
class InitialNotificationState extends NotificationState {

  @override
  String toString() {
    return 'InitialNotificationState{}';
  }
}

class GetPrefsSuccess extends NotificationState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}

class NotificationLoading extends NotificationState {

  @override
  String toString() => 'NotificationLoading';
}
