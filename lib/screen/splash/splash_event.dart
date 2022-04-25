import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetListNotificationSplashEvent extends SplashEvent {

  @override
  String toString() => '';
}