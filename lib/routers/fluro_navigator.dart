import 'package:flutter/material.dart';

/// Fluro's routing and jump tool class
class NavigatorUtils {
  static push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Navigator.pushNamed(context, path, arguments: null);
  }

  static pushReplacementNamed(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Navigator.pushReplacementNamed(context, path, arguments: null);
  }

  /// return
  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  /// return with parameters
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

  /// jump to WebView page
// static goWebViewPage(BuildContext context, String title, String url) {
//   push(context, RouterGenerator.routeWebview);
// }
}
