import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {

  @override
  String toString() => 'RegisterInitial';
}

class RegisterLoading extends RegisterState {
  @override
  String toString() => 'RegisterLoading';
}

class RegisterSuccess extends RegisterState {

  final String? mess;

  RegisterSuccess(this.mess);

  @override
  String toString() {
    return 'RegisterSuccess{mess: $mess}';
  }
}

class RegisterFailure extends RegisterState {
  final String? error;

  RegisterFailure(this.error);

  @override
  String toString() => 'RegisterFailure { error: $error }';
}

class ChooseSexSuccess extends RegisterState {

  @override
  String toString() {
    return 'ChooseSexSuccess{}';
  }
}

class GetOTPSuccess extends RegisterState {
  final String verificationId;
  final String userName;

  GetOTPSuccess(this.verificationId,this.userName);

  @override
  String toString() => 'GetOTPSuccess { verificationId: $verificationId }';
}

class ResetPassWordSuccess extends RegisterState {

  final String? mess;

  ResetPassWordSuccess(this.mess);

  @override
  String toString() => 'ResetPassWordSuccess { }';
}

class ValidateErrorPasswordNew extends RegisterState {
  final String error;

  ValidateErrorPasswordNew(this.error);

  @override
  String toString() => 'ValidateErrorPasswordNew { error: $error }';
}

class ValidateErrorAgainPasswordNew extends RegisterState {
  final String error;

  ValidateErrorAgainPasswordNew(this.error);

  @override
  String toString() => 'ValidateErrorAgainPasswordNew { error: $error }';
}
