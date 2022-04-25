import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maw/models/network/request/login_request.dart';
import 'package:maw/models/network/request/register_request.dart';
import 'package:maw/models/network/request/reset_pass_request.dart';
import 'package:maw/utils/const.dart';
import 'package:maw/utils/log.dart';
import 'package:maw/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'host.dart';

class NetWorkFactory{
  BuildContext context;
  Dio? _dio;
  SharedPreferences? _sharedPreferences;
  bool? isGoogle;
  String? refToken;
  String? token;

  NetWorkFactory(this.context) {
    HostSingleton hostSingleton = HostSingleton();
    hostSingleton.showError();
    String host = hostSingleton.host;
    int port = hostSingleton.port;
    if (!host.contains("http")) {
      host = "http://" + host;
    }
    _dio = Dio(BaseOptions(
      baseUrl: "$host${port!=0?":$port":""}",
      receiveTimeout: 60000,
      connectTimeout: 60000,
    ));
    _setupLoggingInterceptor();
  }

  void _setupLoggingInterceptor(){
    int maxCharactersPerLine = 200;
    refToken = Const.REFRESH_TOKEN;
    _dio!.interceptors.clear();
    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options, handler){
        logger.d("--> ${options.method} ${options.path}");
        logger.d("Content type: ${options.contentType}");
        logger.d("Request body: ${options.data}");
        logger.d("<-- END HTTP");
        return handler.next(options);
      },
      onResponse: (Response response, handler) {
        // Do something with response data
        logger.d("<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
        String responseAsString = response.data.toString();
        if (responseAsString.length > maxCharactersPerLine) {
          int iterations = (responseAsString.length / maxCharactersPerLine).floor();
          for (int i = 0; i <= iterations; i++) {
            int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
            if (endingIndex > responseAsString.length) {
              endingIndex = responseAsString.length;
            }
            print(responseAsString.substring(i * maxCharactersPerLine, endingIndex));
          }
        } else {
          logger.d(response.data);
        }
        logger.d("<-- END HTTP");
        return handler.next(response); // continue
      },
        onError: (DioError error,handler) async{
          // Do something with response error
          logger.e("DioError: ${error.message}");
          if (error.response?.statusCode == 402) {
            try {
              await _dio!.post(
                  "https://refresh.api",
                  data: jsonEncode(
                      {"refresh_token": refToken}))
                  .then((value) async {
                if (value.statusCode == 201) {
                  //get new tokens ...
                  //set bearer
                  error.requestOptions.headers["Authorization"] =
                      "Bearer " + token!;
                  //create request with new access token
                  final opts = Options(
                      method: error.requestOptions.method,
                      headers: error.requestOptions.headers);
                  final cloneReq = await _dio!.request(error.requestOptions.path,
                      options: opts,
                      data: error.requestOptions.data,
                      queryParameters: error.requestOptions.queryParameters);

                  return handler.resolve(cloneReq);
                }
                return handler.next(error);
              });
              return handler.next(error);
            } catch (e, st) {
              logger.e(e.toString());
            }
          }

          if (error.response?.statusCode == 401) {
            // Utils.showToast('Hết phiên làm việc');
            // libGetX.Get.offAll(LoginPage());
          }
          return handler.next(error); //continue
        })
    );
  }

  Future<Object> requestApi(Future<Response> request) async {
    try {
      Response response = await request;
      var data = response.data;
      if (data["statusCode"] == 200 || data["status"] == 200 || data["status"] == "OK") {
        return data;
      } else {
        if (data["statusCode"] == 423) {
          //showOverlay((context, t) => UpgradePopup(message: data["message"],));
        } else if (data["statusCode"] == 401) {
          try {
            // Authen authBloc =
            // BlocProvider.of<AuthenticationBloc>(context);
            // authBloc.add(LoggedOut());
          } catch (e) {
            debugPrint(e.toString());
          }
        }
        return data["message"];
      }
    } catch (error, stacktrace) {
      return _handleError(error);
    }
  }

  String _handleError(dynamic error) {
    String errorDescription = "";
    logger.e(error?.toString());
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.sendTimeout:
          errorDescription = 'ErrorRTS';
          break;
        case DioErrorType.cancel:
          errorDescription = 'ErrorSWC';
          break;
        case DioErrorType.connectTimeout:
          errorDescription = 'ErrorCTS';
          break;
        case DioErrorType.other:
          errorDescription = 'ErrorTSF';
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = 'ErrorRTR';
          break;
        case DioErrorType.response:
          var errorData = error.response?.data;
          String? message;
          int? code;
          if (!Utils.isEmpty(errorData)) {
            if(errorData is String){
              message = 'Error404';
              code = 404;
            } else{
              message = errorData["message"].toString();
              code = errorData["statusCode"];
            }
          } else {
            code = error.response!.statusCode;
          }
          errorDescription = message ?? "ErrorCode" + ': $code';
          if (code == 401) {
            try {
              //libGetX.Get.offAll(LoginPage());
              // MainBloc mainBloc = BlocProvider.of<MainBloc>(context);
              // mainBloc.add(LogoutMainEvent());
            } catch (e) {
              debugPrint(e.toString());
            }
          } else if (code == 423) {
            try {
              // AuthenticationBloc authBloc =
              // BlocProvider.of<AuthenticationBloc>(context);
              // authBloc.add(ShowUpgradeDialogEvent(message ?? ""));
            } catch (e) {
              debugPrint(e.toString());
            }
            //showOverlay((context, t) => UpgradePopup(message: message ?? "",), duration: Duration.zero);
          }
          break;
        default:
          errorDescription = 'Có lỗi xảy ra.';
      }
    } else {
      errorDescription = 'Có lỗi xảy ra.';
    }
    return errorDescription;
  }

  /// List API
  Future<Object> getConnection() async {
    return await requestApi(_dio!.get('api/check-connect'));
  }

  Future<Object> login(LoginRequestBody request) async {
    return await requestApi(_dio!.post('/api/v1/taikhoan/dangnhap', data: request.toJson()));
  }

  Future<Object> resetPassword(ResetPassRequest request) async {
    return await requestApi(_dio!.post('/api/v1/taikhoan/reset-matkhau', data: request.toJson()));
  }

  Future<Object> registerAccount(RegisterRequest request) async {
    return await requestApi(_dio!.post('/api/v1/taikhoan/dangky', data: request.toJson()));
  }

  Future<Object> readNotification(String token) async {
    return await requestApi(_dio!.get('/api/v1/thongbao/chuadoc', options: Options(headers: {"Authorization": "Bearer $token"}))); //["Authorization"] = "Bearer " + token
  }

  Future<Object> getListNotification(String token,int pageIndex,int pageSize) async {
    return await requestApi(_dio!.get('/api/v1/thongbao', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "PageIndex": pageIndex,
      "pageSize": pageSize,
    })); //["Authorization"] = "Bearer " + token
  }

  Future<Object> updateAllNotification(String token) async {
    return await requestApi(_dio!.put('/api/v1/thongbao/read-all', options: Options(headers: {"Authorization": "Bearer $token"}))); //["Authorization"] = "Bearer " + token
  }

  Future<Object> updateNotification(String token,String idNotification) async {
    return await requestApi(_dio!.put('/api/v1/thongbao/' + idNotification, options: Options(headers: {"Authorization": "Bearer $token"}))); //["Authorization"] = "Bearer " + token
  }

  Future<Object> deleteNotification(String token,String idNotification) async {
    return await requestApi(_dio!.delete('/api/v1/thongbao/' + idNotification, options: Options(headers: {"Authorization": "Bearer $token"}))); //["Authorization"] = "Bearer " + token
  }

  Future<Object> deleteAllNotification(String token) async {
    return await requestApi(_dio!.delete('/api/v1/thongbao/xoahet', options: Options(headers: {"Authorization": "Bearer $token"}))); //["Authorization"] = "Bearer " + token
  }

  Future<Object> getListWaterFactory(String token,int pageIndex,int pageSize) async {
    return await requestApi(_dio!.get('/api/v1/nhamaynuoc', options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {
      "PageIndex": pageIndex,
      "pageSize": pageSize,
    })); //["Authorization"] = "Bearer " + token
  }
}