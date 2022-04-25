import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:maw/models/network/response/login_response.dart';
import 'package:maw/themes/colors.dart';
import 'package:maw/themes/images.dart';
import 'package:oktoast/oktoast.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custom_toast.dart';
import 'const.dart';

class Utils{

  static bool isEmpty(Object text) {
    if (text is String) return text.isEmpty;
    if (text is List) return  text.isEmpty;
    // ignore: unnecessary_null_comparison
    return text == null;
  }

  static void showCustomToast(BuildContext context,IconData icon, String title){
    final ToastFuture toastFuture = showToastWidget(
      customToast(context, icon, title),
      duration: const Duration(seconds: 3),
      onDismiss: () {},
    );
    Future<void>.delayed(const Duration(seconds: 2), () {
      toastFuture.dismiss(); // dismiss
    });
  }

  static navigateNextFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void showModalBottom(BuildContext context, String title, String content){
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        isScrollControlled: false,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 10,left: 16,right: 16,bottom: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0,left: 16,right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.check,color: Colors.white,),
                      Text(title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
                      InkWell(
                          onTap: ()=> Navigator.pop(context),
                          child: const Icon(Icons.close,color: Colors.black,)),
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                const Divider(color: Colors.blueGrey,),
                const SizedBox(height: 8,),
                Expanded(child: SingleChildScrollView(child: HtmlWidget(content))),
                const SizedBox(height: 15,),
              ],
            ),
          );
        });
  }

  static void showBottomChat(BuildContext context, String title, String content){
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 10,left: 16,right: 16,bottom: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0,left: 16,right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.check,color: Colors.white,),
                      Text(title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
                      InkWell(
                          onTap: ()=> Navigator.pop(context),
                          child: const Icon(Icons.close,color: Colors.black,)),
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                const Divider(color: Colors.blueGrey,),
                const SizedBox(height: 8,),
                HtmlWidget(content),
                const SizedBox(height: 15,),
              ],
            ),
          );
        });
  }

  static String formatMoney(dynamic amount) {
    return NumberFormat.simpleCurrency(locale: "vi_VN").format(amount)
        .replaceAll(' ', '').replaceAll('.', ' ')
        .replaceAll('₫', '');
  }

  static String formatTotalMoney(dynamic amount) {

    String totalMoney = NumberFormat.simpleCurrency(locale: "vi_VN").format(amount)
        .replaceAll(' ', '').replaceAll('.', ' ')
        .replaceAll('₫', '').toString();
    if(totalMoney.split(' ').length == 1 || totalMoney.split(' ').length == 2){
      return totalMoney;
    }else{
      return totalMoney.split(' ')[0] + ' '+ totalMoney.split(' ')[1];
    }
  }

  static String formatMoneyVN(num money) {
    String convertMoney = money.toString();
    if(convertMoney.split('.')[0].length > 3){
      String m = convertMoney.split('.')[0].substring(0,convertMoney.split('.')[0].length-3);
      money = num.parse(m);
    }
    if (money <= 0) return "0K";
    return formatNumber(money) + "K";
  }

  static String formatNumber(num amount) {
    return isInteger(amount) ? amount.toStringAsFixed(0) : amount.toString();
  }

  static bool isInteger(num value) => value is int || value == value.roundToDouble();

  static DateTime? parseStringToDate(String dateStr, String format) {
    DateTime? date;
    try {
      date = DateFormat(format).parse(dateStr);
    } on FormatException catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return date;
  }

  static String parseDateTToString(String dateInput,String format){
    String date = "";
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dateInput);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat(format);
    date = outputFormat.format(inputDate);
    return date;
  }

  static String parseStringDateToString(String dateSv, String fromFormat, String toFormat) {
    String date = "";
    try {
      date = DateFormat(toFormat, "en_US")
          .format(DateFormat(fromFormat).parse(dateSv));
    } on FormatException catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return date;
  }

  static String parseDateToString(DateTime dateTime, String format) {
    String date = "";
    try {
      date = DateFormat(format).format(dateTime);
    } on FormatException catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return date;
  }

  static Future navigatePage(BuildContext context, Widget widget) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget, ));
  }

  static void showDialogTwoButton(
      {required BuildContext context,
        String? title,
        required Widget contentWidget,
        required List<Widget> actions,
        bool dismissible = false}) =>
      showDialog(
          barrierDismissible: dismissible,
          context: context,
          builder: (context) {
            return AlertDialog(
                title: title != null ? Text(title) : null,
                content: contentWidget,
                actions: actions);
          });

  static void saveDataLogin(SharedPreferences _prefs, LoginResponseData data,String accessToken, String refreshToken,String username,String pass) {
    _prefs.setString(Const.USER_ID, data.taiKhoan!.id.toString());
    _prefs.setString(Const.ACCESS_TOKEN, accessToken);
    _prefs.setString(Const.REFRESH_TOKEN, refreshToken);
    _prefs.setString(Const.USER_NAME, data.taiKhoan!.hoTen??"");
    _prefs.setString(Const.PHONE_NUMBER, data.taiKhoan!.soDienThoai??"");
    _prefs.setString(Const.EMAIL, data.taiKhoan!.email??"");
    _prefs.setString(Const.BIRTH_DAY, data.taiKhoan!.ngaySinh??"");
    _prefs.setInt(Const.SEX, data.taiKhoan!.gioiTinh??0);
    _prefs.setString(Const.ADDRESS, data.taiKhoan!.diaChi??"");
  }

  static void removeData(SharedPreferences _prefs) {
    _prefs.remove(Const.USER_ID);
    _prefs.remove(Const.USER_NAME);
    _prefs.remove(Const.ACCESS_TOKEN);
    _prefs.remove(Const.REFRESH_TOKEN);
    _prefs.remove(Const.PHONE_NUMBER);
    _prefs.remove(Const.EMAIL);
    _prefs.remove(Const.BIRTH_DAY);
    _prefs.remove(Const.SEX);
    _prefs.remove(Const.ADDRESS);
  }

  static void showForegroundNotification(BuildContext context, String title, String text, {VoidCallback? onTapNotification}) {
    showOverlayNotification((context) {
      return Padding(
        padding: const EdgeInsets.only(top: 38,left: 8,right: 8),
        child: Material(
          color: Colors.transparent,
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: InkWell(
                onTap: () {
                  OverlaySupportEntry.of(context)!.dismiss();
                  onTapNotification!();
                },
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: const BorderRadius.all(Radius.circular(60)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child: Image.asset(icLogo,fit: BoxFit.contain,scale: 2,),
                    ),
                  ),
                  title: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                  subtitle: Text(text,style:  const TextStyle(color: Colors.black),),
                  trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        OverlaySupportEntry.of(context)!.dismiss();
                      }),
                ),
              ),
            ),
          ),
        ),
      );
    }, duration: const Duration(milliseconds: 4000));
  }
}