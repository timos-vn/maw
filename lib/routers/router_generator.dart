import 'package:flutter/material.dart';

import '../screen/login/login_screen.dart';
import '404.dart';

class RouterGenerator {
  //* Routing list
  static const routeHome = "/home";
  static const routeAction = "/action";
  static const routeAccount = "/account";
  static const routeIntro = "/intro";
  static const routeLoginScreen = "/login";
  static const routeSignUpScreen = "/sign";
  static const otpScreen = "/otpRouter";
  static const routeAuthScreen = "/auth";
  static const routeDetail = "/detail";
  static const routeMap = "/mapRouter";
  static const mainScreen = "/mainRouter";
  static const findScreen = "/findRouter";


  static Route<dynamic> generateRouter(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // case routeIntro:
      //   return MaterialPageRoute(
      //       builder: (_) => OnBoardingPage());
      //   break;
      case routeLoginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
        break;
      // case routeSignUpScreen:
      //   return MaterialPageRoute(builder: (_) => RegisterScreen());
      //   break;
      // case otpScreen:
      //   return MaterialPageRoute(builder: (_) => OtpInputScreen());
      //   break;
      // case mainScreen:
      //   return MaterialPageRoute(builder: (_) => MainScreen());
      //   break;
      // case routeHome:
      //   return MaterialPageRoute(builder: (_) => HomeScreen());
      //   break;
      // case findScreen:
      //   return MaterialPageRoute(builder: (_) => FindAllTripsScreen());
      //   break;
      // case routeDetail:
      //   if (args is DataBundle) {
      //     return MaterialPageRoute(
      //         builder: (_) => WaitingListDetailScreen(
      //               strDate: args.strDate,
      //               strTuyenDuong: args.strTuyenDuong,
      //               strType: args.strType.toString(),
      //             ));
      //   }
      //   break;
      // case routeMap:
      //   if (args is DataBundle) {
      //     return MaterialPageRoute(
      //         builder: (_) => MapScreen(
      //               strAddress: args.strAddress,
      //             ));
      //   }
      //   break;
      default:
        {
          return MaterialPageRoute(builder: (_) => WidgetNotFound());
        }
        break;
    }
  }
}
