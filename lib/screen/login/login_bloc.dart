import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw/models/network/request/login_request.dart';
import 'package:maw/models/network/response/login_response.dart';
import 'package:maw/models/network/services/network_factory.dart';
import 'package:maw/utils/const.dart';
import 'package:maw/utils/utils.dart';
import 'package:maw/utils/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_event.dart';
import 'login_sate.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState> with Validators{

  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;
  String? _deviceToken;
  SharedPreferences? _prefs;
  String? _username;
  String? get username => _username;
  String?  _errorUsername, _errorPass;
  // DatabaseHelper db = DatabaseHelper();
  // List<AccountInfo> listAccountInfo = new List<AccountInfo>();
  String? codeLang = "v";
  // Position currentLocation;
  String? currentAddress;
  bool isGrantCamera = false;
  int rewardPoints=0;
  String? phoneNumber;

  LoginBloc(this.context) : super(LoginInitial()) {
    _networkFactory = NetWorkFactory(context);
    on<GetPrefs>(_getPrefs,);
    on<ValidateUsername>(_checkValidateUserName,);
    on<ValidatePass>(_checkValidatePassWord,);
    on<Login>(_login,);
    // getTokenFCM();
  }

  void _getPrefs(GetPrefs event, Emitter<LoginState> emitter)async{
    emitter(LoginLoading());
    _prefs = await SharedPreferences.getInstance();
    _username = _prefs!.getString(Const.USER_NAME) ?? "";
    _accessToken = _prefs!.getString(Const.ACCESS_TOKEN) ?? "";
    _refreshToken = _prefs!.getString(Const.REFRESH_TOKEN) ?? "";
    emitter(LoginInitial());
  }

  void _checkValidateUserName(ValidateUsername event, Emitter<LoginState> emitter) async{
    emitter(LoginInitial());
    String? error = checkUsername(context, event.username) ?? '';
    emitter(ValidateErrorUsername(error));
  }

  void _checkValidatePassWord(ValidatePass event, Emitter<LoginState> emitter) async{
    emitter(LoginInitial());
    String? error = checkPass(context, event.pass) ?? '';
    emitter(ValidateErrorPassword(error));
  }

  void _login(Login event, Emitter<LoginState> emitter) async{
    emitter(LoginLoading());
    LoginRequestBody request = LoginRequestBody(
      username:event.username, /// 0975833263
      password:event.password, /// 0975833263
    );
    LoginState state = _handleLogin(await _networkFactory!.login(request),event.savePassword,event.username,event.password);
    emitter(state);
  }


  // getTokenFCM()async{
  //   // token = await FirebaseMessaging.instance.getAPNSToken();
  //   FirebaseMessaging.instance.getToken().then((token) {
  //     print("_token");
  //     print(token);
  //     _deviceToken = token;
  //   });
  //   // if(!Utils.isEmpty(token)){
  //   //   print('token: ${token.toString()}');
  //   // }
  // }

  // LoginState get initialState => LoginInitial();
  //
  // Stream<LoginState> mapEventToState(LoginEvent event) async*  {
  //   // TODO: implement mapEventToState
  //   if (_prefs == null) {
  //     _prefs = await SharedPreferences.getInstance();
  //     _username = _prefs!.getString(Const.USER_NAME) ?? "";
  //     _accessToken = _prefs!.getString(Const.ACCESS_TOKEN) ?? "";
  //     _refreshToken = _prefs!.getString(Const.REFRESH_TOKEN) ?? "";
  //   }
  //   if(event is SaveUserNamePassWordEvent){
  //     // yield LoginLoading();
  //     // listAccountInfo = await getListAccountInfoFromDb();
  //     // if(!Utils.isEmpty(listAccountInfo)){
  //     //   yield SaveUserNamePasswordSuccessful(listAccountInfo[0].userName,listAccountInfo[0].pass,);
  //     // }
  //     // yield LoginInitial();
  //   }
  //   // else if(event is GetLocationEvent){}
  //   // else if(event is UpdateTokenDiveEvent){
  //   //   yield LoginLoading();
  //   //   UpdateTokenRequestBody request = UpdateTokenRequestBody(
  //   //       deviceToken: event.deviceToken
  //   //   );
  //   //   LoginState state = _handleUpdateToken(await _networkFactory.updateToken(request,_accessToken));
  //   //   yield state;
  //   // }
  //   // if (event is Login) {
  //   //   yield LoginLoading();
  //   //   LoginRequestBody request = LoginRequestBody(
  //   //     username:event.username, /// 0975833263
  //   //     password:event.password, /// 0975833263
  //   //   );
  //   //   LoginState state = _handleLogin(await _networkFactory.login(request),event.savePassword,event.username,event.password);
  //   //   yield state;
  //   // }
  //   //
  //   // if (event is ValidateUsername) {
  //   //   yield LoginInitial();
  //   //   String? error = checkUsername(context, event.username);
  //   //   yield ValidateErrorUsername(error!);
  //   // }
  //   // on<ValidateUsername>((event, emit){
  //   //   // LoginInitial();
  //   //   String? error = checkUsername(context, event.username);
  //   //   return ValidateErrorUsername(error!);
  //   // });
  //   if (event is ValidatePass) {
  //     yield LoginInitial();
  //     String? error = checkPass(context, event.pass);
  //     yield ValidateErrorPassword(error!);
  //   }
  // }

  LoginState _handleUpdateToken(Object data) {
    if (data is String) return LoginFailure(data);
    try {
      return UpdateTokenSuccessState();
    } catch (e) {
      return LoginFailure(e.toString());
    }
  }

  LoginState _handleLogin(Object data,bool savePassword,String username,String pass) {
    if (data is String) return LoginFailure(data);
    try {
      LoginResponse response = LoginResponse.fromJson(data as Map<String,dynamic>);
      LoginResponseData? loginResponseData = response.data;
      _accessToken = loginResponseData!.accessToken;
      _refreshToken = loginResponseData.refreshToken;
      LoginResponseData dataUser = loginResponseData;
      _username = dataUser.taiKhoan!.hoTen.toString().trim();
      phoneNumber = dataUser.taiKhoan!.soDienThoai;
      Utils.saveDataLogin(_prefs!, dataUser,_accessToken!,_refreshToken!,username,pass);
      // add(UpdateTokenDiveEvent(_deviceToken));
      // pushService(username,pass,savePassword);
      return LoginSuccess("_deviceToken");
    } catch (e) {
      return LoginFailure(e.toString());
    }
  }

  void checkUsernameBloc(String username) {
    String? _tempErrUsername = checkUsername(context, username);
    if (_errorUsername != _tempErrUsername) {
      _errorUsername = _tempErrUsername;
      add(ValidateUsername(username));
    }
  }

  void checkPassBloc(String pass) {
    String? _tempErrPass = checkPass(context, pass);
    if (_errorPass != _tempErrPass) {
      _errorPass = _tempErrPass;
      add(ValidatePass(pass));
    }
  }

  // void pushService(String username, String pass,bool savePass) async{
  //   if(savePass == true){
  //     AccountInfo infoAccount = new AccountInfo(
  //         !Utils.isEmpty(MyTranslations.newCodeLocale) ? MyTranslations.newCodeLocale :'vi',
  //         !Utils.isEmpty(MyTranslations.newLocale) ? MyTranslations.newLocale :'Tiếng Việt',
  //         username,
  //         pass
  //     );
  //     await db.saveAccount(infoAccount);
  //     listAccountInfo = await getListAccountInfoFromDb();
  //     if(!Utils.isEmpty(listAccountInfo)){
  //       db.updateAccountInfo(infoAccount);
  //     }
  //   }else{
  //     db.deleteAllAccountInfo();
  //   }
  // }
  // Future<List<AccountInfo>> getListAccountInfoFromDb() {
  //   return db.fetchAllAccountInfo();
  // }
}