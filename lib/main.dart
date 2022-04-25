import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maw/screen/splash/splash_screen.dart';
import 'package:maw/themes/colors.dart';
import 'package:oktoast/oktoast.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarIconBrightness: Brightness.dark,));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Permission.location.request();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final key = const ValueKey('my overlay');
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      key: key,
      child: OKToast(
        child: GetMaterialApp(
          title: "Enter Buy",
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
            primaryColor: color_app,
            backgroundColor: color_app,
            //fontFamily: "Montserrat",
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryTextTheme: const TextTheme(headline6: TextStyle(color: Colors.white)),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          // locale: MyTranslations.locale,
          // fallbackLocale: MyTranslations.fallbackLocale,
          // translations: MyTranslations(),
          home: const SplashScreen(),
          // onGenerateRoute: RouterGenerator.generateRouter,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
