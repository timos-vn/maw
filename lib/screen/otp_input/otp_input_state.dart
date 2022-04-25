import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OtpInputState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialOtpInputState extends OtpInputState {}

class OtpInputLoading extends OtpInputState {
  @override
  String toString() => 'OtpInputLoading';
}

class SendOtpSuccess extends OtpInputState {

  @override
  String toString() => 'SendOtpSuccess';
}

class RegisterOtpSuccess extends OtpInputState {

  final String otp;

  RegisterOtpSuccess({required this.otp});

  @override
  String toString() => 'RegisterOtpSuccess{otp: $otp}';
}

class OtpInputFailure extends OtpInputState {
  final String error;

  OtpInputFailure(this.error);

  @override
  String toString() => 'OtpInputFailure { error: $error }';
}


class OtpInputExpired extends OtpInputState {
  final String error;

  OtpInputExpired(this.error);

  @override
  String toString() => 'OtpInputExpired { error: $error }';
}

class ValidateOtpError extends OtpInputState {
  final String error;

  ValidateOtpError(this.error);

  @override
  String toString() => 'ValidateOtpError { error: $error }';
}

class GetOTPFinishState extends OtpInputState {
  final String verificationId;
  final String userName;

  GetOTPFinishState(this.verificationId,this.userName);

  @override
  String toString() => 'GetOTPFinishState { verificationId: $verificationId }';
}

class RegisterSuccess extends OtpInputState {

  final String mess;

  RegisterSuccess(this.mess);

  @override
  String toString() {
    return 'RegisterSuccess{mess: $mess}';
  }
}

class LoginSuccess extends OtpInputState {

  @override
  String toString() => 'LoginSuccess';
}

class AwaitVerityOTPState extends OtpInputState {
  @override
  String toString() => 'AwaitVerityOTPState';
}
class FinishVerityOTPState extends OtpInputState {
  @override
  String toString() => 'FinishVerityOTPState';
}

class VerityOTPFailState extends OtpInputState {
  @override
  String toString() => 'VerityOTPFailState';
}