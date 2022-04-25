import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw/models/network/request/reset_pass_request.dart';
import 'package:maw/models/network/response/entity_response.dart';
import 'package:maw/models/network/services/network_factory.dart';
import 'package:maw/utils/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/network/request/register_request.dart';
import 'register_event.dart';
import 'register_sate.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState> with Validators{

  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;
  String? _deviceToken;
  SharedPreferences? _prefs;
  String? _sex;
  String? get sex => _sex;
  int? idSex;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _errorUsername, _errorPass, _errorAgainPass;

  RegisterBloc(this.context) : super(RegisterInitial()) {
    _networkFactory = NetWorkFactory(context);
    on<ChooseSex>(_chooseSexBloc);
    on<GetOTPEvent>(_getOTP);
    on<GetOTPEventFail>(_getOTPEventFail);
    on<GetOTPEventFinish>(_getOTPEventFinish);
    on<RegisterAccountEvent>(_registerAccount);
    on<ValidatePasswordNewEvent>(_validatePasswordNewEvent);
    on<ValidateAgainPasswordNewEvent>(_validateAgainPasswordNewEvent);
    on<ResetPassWordEvent>(_resetPassWordEvent);
  }

  void _chooseSexBloc(ChooseSex event, Emitter<RegisterState> emitter) async{
    emitter(RegisterLoading());
    _sex = event.sex;
    if(_sex=='Nữ'){
      idSex = 0;
    }else if(_sex =='Nam'){
      idSex = 1;
    }else{
      idSex = 2;
    }
    emitter(ChooseSexSuccess());
  }

  void _getOTP(GetOTPEvent event,Emitter<RegisterState> emitter){
    emitter(RegisterLoading());
    getOTP(event.userName);
  }

  void _getOTPEventFail(GetOTPEventFail eventFail,Emitter<RegisterState> emitter){
    emitter(RegisterFailure(eventFail.error));
  }

  void _getOTPEventFinish(GetOTPEventFinish eventFinish,Emitter<RegisterState> emitter){
    emitter(GetOTPSuccess(eventFinish.phoneAuthCredential,eventFinish.userName));
  }

  void getOTP(String phoneNumber)async{
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
      },
      verificationFailed: (verificationFailed) async {
        add(GetOTPEventFail(verificationFailed.message.toString()));
      },
      codeSent: (String verId, [ int? forceCodeResend]) async {
        add(GetOTPEventFinish(verId,phoneNumber));
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }

  void _registerAccount(RegisterAccountEvent event,Emitter<RegisterState> emitter)async{
    emitter(RegisterLoading());
    RegisterRequest request = RegisterRequest(
        tenDangNhap: event.phoneNumber,
        matKhau: event.password,
        hoTen: event.username,
        ngaySinh: event.birthday,
        soDienThoai: event.phoneNumber,
        gioiTinh: idSex,
        diaChi: event.address
    );
    RegisterState state = _handleEntity(await _networkFactory!.registerAccount(request));
    emitter(state);
  }

  void _resetPassWordEvent(ResetPassWordEvent event,Emitter<RegisterState> emitter)async{
    emitter(RegisterLoading());
    ResetPassRequest request = ResetPassRequest(
        tenDangNhap: event.phoneNumber,
        matKhau: event.pass,
    );
    RegisterState state = _handleEntity(await _networkFactory!.resetPassword(request));
    emitter(state);
  }

  void checkPasswordOldBloc(String username) {
    String? _tempErrUsername = checkPass(context, username);
    if (_errorUsername != _tempErrUsername) {
      _errorUsername = _tempErrUsername;
      add(ValidatePasswordOldEvent(username));
    }
  }

  void checkPasswordNewBloc(String pass) {
    String? _tempErrPass = checkPass(context, pass);
    if (_errorPass != _tempErrPass) {
      _errorPass = _tempErrPass;
      add(ValidatePasswordNewEvent(pass));
    }
  }

  void checkAgainPassBloc( String currentPassword, String newPassword) {
    String? _tempErrPass = checkPassAgain(context, currentPassword,newPassword);
    if (_errorAgainPass != _tempErrPass) {
      _errorAgainPass = _tempErrPass;
      add(ValidateAgainPasswordNewEvent(currentPassword,newPassword));
    }
  }

  void _validatePasswordNewEvent(ValidatePasswordNewEvent event,Emitter<RegisterState> emitter){
    emitter(RegisterInitial());
    String? error = checkPass(context, event.pass);
    emitter(ValidateErrorPasswordNew(error!));
  }

  void _validateAgainPasswordNewEvent(ValidateAgainPasswordNewEvent event,Emitter<RegisterState> emitter){
    emitter(RegisterInitial());
    String? error = checkPassAgain(context, event.currentPassword, event.newPassword);
    emitter(ValidateErrorAgainPasswordNew(error!));
  }

  RegisterState _handleEntity(Object data) {
    if (data is String) return RegisterFailure(data);
    try {
      EntityResponse response = EntityResponse.fromJson(data as Map<String,dynamic>);
      return ResetPassWordSuccess(response.message);
    } catch (e) {
      return RegisterFailure(e.toString());
    }
  }
}