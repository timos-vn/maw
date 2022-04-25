import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {
  @override
  String toString() => 'SplashInitial';
}

class SplashLoading extends SplashState {
  @override
  String toString() => 'SplashLoading';
}

class GetListNotificationSplashSuccess extends SplashState {

  @override
  String toString() {
    return 'GetListNotificationSplashSuccess{}';
  }
}
class GetListNotificationSplashFailure extends SplashState {
  final String error;

  GetListNotificationSplashFailure(this.error);

  @override
  String toString() => 'GetListNotificationSplashFailure { error: $error }';
}