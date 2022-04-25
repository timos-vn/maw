import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw/screen/login/login_screen.dart';
import 'package:maw/screen/main/main_screen.dart';
import 'package:maw/screen/splash/splash_bloc.dart';
import 'package:maw/screen/splash/splash_state.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../routers/fluro_navigator.dart';
import '../../routers/router_generator.dart';
import '../../utils/auth_atils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  var _visible = true;
  bool isGrantCamera = false;
  late AnimationController animationController;
  Animation<double>? animation;
  SplashBloc? _bloc;

  // ignore: prefer_typing_uninitialized_variables
  var _token;

  startTime() async {
    var _duration = const Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async{
    _token = await AuthUtils.instance.getToken();
    if (_token != null) {
      pushNewScreen(context, screen: const MainScreen());
    } else {
      pushNewScreen(context, screen: const LoginScreen());
    }
  }



  @override
  void initState() {
    super.initState();
    _bloc = SplashBloc(context);

    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation!.addListener(() => setState(() {}));
    animationController.forward();
    if (!mounted) return;
    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<SplashBloc,SplashState>(
        bloc: _bloc,
        listener: (context,state){
          if(state is GetListNotificationSplashSuccess){
            NavigatorUtils.pushReplacementNamed(context, RouterGenerator.routeLoginScreen,);
          }else if (state is GetListNotificationSplashFailure){
            NavigatorUtils.pushReplacementNamed(
                context, RouterGenerator.routeLoginScreen);
          }
        },
        child: BlocBuilder<SplashBloc,SplashState>(
          bloc: _bloc,
          builder: (BuildContext context, SplashState state){
            return  Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Visibility(
                  visible:  state is SplashLoading,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text(
                        "Loading",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                 Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/splash1.png',
                      width: animation!.value * 250,
                      height: animation!.value * 250,
                      // width:  250,
                      // height: 250,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
