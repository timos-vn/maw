import 'dart:io';
import 'dart:io' show Platform;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' as libGetX;
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw/models/network/response/unread_count_response.dart';
import 'package:maw/models/network/services/network_factory.dart';
import 'package:maw/utils/const.dart';
import 'package:maw/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_event.dart';
import 'main_state.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Utils.showForegroundNotification(contexts!, message.notification!.title.toString(), message.notification!.body.toString(), onTapNotification: () {
  },);
}
BuildContext? contexts;
class MainBloc extends Bloc<MainEvent, MainState> {
  int? userId;
  // Position? currentLocation;
  BuildContext? context;
  SharedPreferences? _pref;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  SharedPreferences? get pref => _pref;
  bool isGrantCamera = false;
  String? _deviceToken;
  int countNotifyUnRead=0;
  String? userName,email,phoneNumber;
  int? pointUser;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;

  NetWorkFactory? _networkFactory;
  static final _messaging = FirebaseMessaging.instance;

  init(BuildContext context) {
    if (this.context == null) {
      this.context = context;
    }
    _networkFactory = NetWorkFactory(context);
  }

  registerUpPushNotification() {
    //REGISTER REQUIRED FOR IOS
    if (Platform.isIOS) {
      _messaging.requestPermission();
    }
    _messaging.getToken().then((value) {
      if (value == null) return;
    });
  }

  _listenToPushNotifications() {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(badge: true, alert: true, sound: true);
    contexts = context;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      subscribeToTopic(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      subscribeToTopic(message);
    });
  }

  void subscribeToTopic(RemoteMessage message){
   Utils.showForegroundNotification(context!, message.notification!.title.toString(), message.notification!.body.toString(), onTapNotification: () {},);
  }

  void showNotification({String? title, String? body,})async {
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('arrive'),
        showWhen: true);

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }


  MainBloc() : super(InitialMainState()){
    registerUpPushNotification();
    _listenToPushNotifications();
    on<GetPrefs>(_getPrefs);
    on<GetDataEvent>(_getDataUser);
    on<LogoutMainEvent>(_logOut);
    on<GetLocationEvent>(_getLocation);
    on<GetCountNotificationUnRead>(_getCountNotificationUnRead);
  }

  void _getPrefs(GetPrefs event, Emitter<MainState> emitter)async{
    emitter(InitialMainState());
    _pref = await SharedPreferences.getInstance();
    userName = _pref!.getString(Const.USER_NAME) ?? "";
    _accessToken = _pref!.getString(Const.ACCESS_TOKEN) ?? "";
    _refreshToken = _pref!.getString(Const.REFRESH_TOKEN) ?? "";
    emitter(GetPrefsSuccess());
  }


  void _getDataUser(GetDataEvent event, Emitter<MainState> emitter)async{
    emitter(InitialMainState());
    _pref = await SharedPreferences.getInstance();
    _accessToken = _pref!.getString(Const.ACCESS_TOKEN) ?? "";
    _refreshToken = _pref!.getString(Const.REFRESH_TOKEN) ?? "";
    userName = _pref!.getString(Const.USER_NAME) ?? "";
    phoneNumber = _pref!.getString(Const.PHONE_NUMBER)??'';
    emitter(GetDataSuccess());
  }

  void _logOut(LogoutMainEvent event, Emitter<MainState> emitter){
    emitter(MainLoading());
    Utils.removeData(_pref!);
    emitter(LogoutSuccess());
  }

  void _getLocation(GetLocationEvent event, Emitter<MainState> emitter){
    emitter(InitialMainState());
    checkPermission();
    emitter(InitialMainState());
  }

  void _getCountNotificationUnRead(GetCountNotificationUnRead event, Emitter<MainState> emitter)async{
    emitter(MainLoading());
    MainState  state = _handleUnreadCountNotify(await _networkFactory!.readNotification(_accessToken!));
    emitter(state);
  }


  void checkPermission()async{
    Map<Permission, PermissionStatus> permissionRequestResult =
    await [Permission.locationAlways,Permission.locationWhenInUse,Permission.location].request();
    if (permissionRequestResult[Permission.location] == PermissionStatus.granted) {
      isGrantCamera = true;
    }
    else {
      if (await Permission.camera.isPermanentlyDenied) {
        Geolocator.openLocationSettings();
      } else {
        isGrantCamera = false;
      }
    }
  }

  MainState _handleUnreadCountNotify(Object data) {
    if (data is String) return MainFailure(data);
    try {
      UnreadCountResponse response = UnreadCountResponse.fromJson(data as Map<String,dynamic>);
      countNotifyUnRead = response.unreadTotal ?? 0;
      return CountNotificationSuccess();
    } catch (e) {
      return MainFailure('Error'.tr);
    }
  }
}
