import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OtpInputEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ValidateOtp extends OtpInputEvent {
  final String otp;

  ValidateOtp(this.otp);

  @override
  String toString() =>
      'ValidateOtp { phoneNumber: $otp }';
}

class VerityOTP extends OtpInputEvent {
  final String? phoneNumber;
  final PhoneAuthCredential phoneAuthCredential;


  VerityOTP({this.phoneNumber,required this.phoneAuthCredential});

  @override
  String toString() =>
      'SendOtp { phoneNumber: $phoneNumber}';
}



class GetOTP extends OtpInputEvent {
  final String userName;

  GetOTP(this.userName);

  @override
  String toString() =>
      'GetOTP { userName: $userName }';
}

class GetOTPFail extends OtpInputEvent {
  final String error;

  GetOTPFail(this.error);

  @override
  String toString() =>
      'GetOTPFail { error: $error }';
}

class GetOTPFinish extends OtpInputEvent {
  final String phoneAuthCredential;
  final String userName;
  GetOTPFinish(this.phoneAuthCredential,this.userName);

  @override
  String toString() => 'GetOTPFinish { }';
}


class AwaitVerityOTP extends OtpInputEvent{
  @override
  String toString() => 'AwaitVerityOTP {}';
}

class FinishVerityOTP extends OtpInputEvent{

  @override
  String toString() => 'FinishVerityOTP {}';
}

class VerityOTPFail extends OtpInputEvent{
  final String mess;

  VerityOTPFail(this.mess);
  @override
  String toString() => 'VerityOTPFail {mess: $mess}';
}