import 'package:equatable/equatable.dart';
import 'package:flutter/semantics.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChooseSex extends RegisterEvent {

  final String sex;

  ChooseSex({required this.sex});

  @override
  String toString() => 'ChooseSex {sex: $sex}';
}

class GetOTPEvent extends RegisterEvent {
  final String userName;

  GetOTPEvent(this.userName);

  @override
  String toString() =>
      'GetOTPEvent { userName: $userName }';
}

class GetOTPEventFail extends RegisterEvent {
  final String error;

  GetOTPEventFail(this.error);

  @override
  String toString() =>
      'GetOTPEventFail { error: $error }';
}

class GetOTPEventFinish extends RegisterEvent {
  final String phoneAuthCredential;
  final String userName;
  GetOTPEventFinish(this.phoneAuthCredential,this.userName);
  @override
  String toString() => 'GetOTPEventFinish { }';
}


class RegisterAccountEvent extends RegisterEvent {

  final String? phoneNumber;
  final String? password;
  final String? username;
  final String? birthday;
  final String? sex;
  final String? email;
  final String? address;

  RegisterAccountEvent({this.username, this.password,this.phoneNumber,this.sex,this.birthday,this.email,this.address});

  @override
  String toString() => 'RegisterAccountEvent {username: $username, password: $password }';
}

class ResetPassWordEvent extends RegisterEvent {

  final String? phoneNumber;
  final String? pass;

  ResetPassWordEvent({this.phoneNumber,this.pass});

  @override
  String toString() => 'ResetPassWordEvent {}';
}

class ValidatePasswordOldEvent extends RegisterEvent {
  final String pass;

  ValidatePasswordOldEvent(this.pass);

  @override
  String toString() => 'ValidateUsername { username: $pass }';
}

class ValidatePasswordNewEvent extends RegisterEvent {
  final String pass;

  ValidatePasswordNewEvent(this.pass);

  @override
  String toString() =>
      'ValidatePass { pass: $pass }';
}

class ValidateAgainPasswordNewEvent extends RegisterEvent {
  final String currentPassword;
  final String newPassword;
  ValidateAgainPasswordNewEvent(this.currentPassword,this.newPassword);

  @override
  String toString() => 'ValidateAgainPasswordNewEvent { currentPassword: $currentPassword, newPassword: $newPassword }';
}
