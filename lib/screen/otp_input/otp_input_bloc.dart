import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maw/models/network/request/register_request.dart';
import 'package:maw/models/network/services/network_factory.dart';
import 'package:maw/utils/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'otp_input_event.dart';
import 'otp_input_state.dart';

class OtpInputBloc extends Bloc<OtpInputEvent, OtpInputState> with Validators {
  NetWorkFactory? _networkFactory;
  BuildContext? context;
  SharedPreferences? _pref;
  String? _deviceToken;
  final FirebaseAuth? _auth = FirebaseAuth.instance;
  String? verificationCode;

  OtpInputBloc(this.context) : super(InitialOtpInputState()) {
    _networkFactory = NetWorkFactory(context!);
    //_firebaseMessaging = FirebaseMessaging();
    // _firebaseMessaging.getToken().then((token) {
    //   _deviceToken = token;
    // });
    if (Platform.isIOS) getIosPermission();
    on<GetOTP>(_getOTP);
    on<GetOTPFail>(_getOTPEventFail);
    on<GetOTPFinish>(_getOTPEventFinish);
    on<VerityOTP>(_verityOTP);
    on<FinishVerityOTP>(_finishVerityOTP);
  }

  void _getOTP(GetOTP event,Emitter<OtpInputState> emitter){
    emitter(OtpInputLoading());
    getOTP(event.userName);
  }

  void _getOTPEventFail(GetOTPFail eventFail,Emitter<OtpInputState> emitter){
    emitter(OtpInputExpired(eventFail.error));
  }

  void _getOTPEventFinish(GetOTPFinish eventFinish,Emitter<OtpInputState> emitter){
    emitter(GetOTPFinishState(eventFinish.phoneAuthCredential,eventFinish.userName));
  }

  void _verityOTP(VerityOTP event,Emitter<OtpInputState> emitter){
    emitter(OtpInputLoading());
    signInWithPhoneAuthCredential(event.phoneAuthCredential,
    event.phoneNumber
    );
  }
  void _finishVerityOTP(FinishVerityOTP event,Emitter<OtpInputState> emitter){
    emitter(FinishVerityOTPState());
  }


  void getOTP(String phoneNumber)async{
    await _auth?.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
      },
      verificationFailed: (verificationFailed) async {
        add(GetOTPFail(verificationFailed.message.toString()));
      },
      codeSent: (String verId, [int? forceCodeResend]) async {
        add(GetOTPFinish(verId,phoneNumber));
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential,String? phoneNumber,) async {
    try {
      final authCredential = await _auth?.signInWithCredential(phoneAuthCredential);
      if(authCredential?.user != null){
        add(FinishVerityOTP());
      }
    } on FirebaseAuthException catch (e) {
      add(VerityOTPFail(e.tenantId! +' - '+ e.message.toString()));
    }
  }

  void getIosPermission() {
    // _firebaseMessaging.requestNotificationPermissions(
    //     IosNotificationSettings(sound: true, badge: true, alert: true));
  }
}
