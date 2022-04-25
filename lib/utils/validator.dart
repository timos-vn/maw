import 'package:flutter/cupertino.dart';

import 'utils.dart';

class Validators{
  static final RegExp _phoneRegex = RegExp(r'(\+84|0)\d{9}$');
  static final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  String? checkPhoneNumber(BuildContext context, String phoneNumber) {
    if (Utils.isEmpty(phoneNumber)) {
      return 'Vui lòng nhập số điện thoại';
    } else if (!_phoneRegex.hasMatch(phoneNumber)) {
      return 'Sai định dạng số điện thoại';
    } else {
      return null;
    }
  }

  String? checkUsername(BuildContext context, String username) {
    if (Utils.isEmpty(username)) {
      return 'PleaseInputUserName';
    } else if (username.length < 10) {
      return 'UsernameNotValid';
    } else if (!Utils.isEmpty(username) && username.substring(0,1) != '0') {
      return 'UsernameNotValid';
    } else {
      return '';
    }
  }

  String? checkPass(BuildContext context, String password) {
    if (Utils.isEmpty(password)) {
      return 'PleaseInputPassword';
    } else if (password.length < 6) {
      return 'PasswordLeastCharacter';
    } else {
      return null;
    }
  }

  String? checkPassAgain(BuildContext context, String currentPassword, String newPassword) {
    if (Utils.isEmpty(newPassword)) {
      return 'PleaseInputPassword';
    } else if (newPassword.length < 6) {
      return 'PasswordLeastCharacter';
    }else if (currentPassword != newPassword){
      return 'Các mật khẩu đã nhập không khớp. Hãy thử lại.';
    }
    else {
      return null;
    }
  }

  String? checkPhoneNumber2(BuildContext context, String phoneNumber) {
    if (Utils.isEmpty(phoneNumber)) return null;
    if (!_phoneRegex.hasMatch(phoneNumber)) {
      return 'PhoneNotValid';
    } else {
      return null;
    }
  }

  String? checkEmail(BuildContext context, String email) {
    if (Utils.isEmpty(email)) {
      return 'PlsInputEmail';
    } else if (!_emailRegex.hasMatch(email)) {
      return 'EmailNotValid';
    } else {
      return null;
    }
  }
}