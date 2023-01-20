import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iotee/core/route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'IoTee',
      theme: ThemeData(
        textTheme: const TextTheme(
          headline1: TextStyle(color: textColor),
          headline2: TextStyle(color: textColor),
          bodyText2: TextStyle(color: textColor),
          subtitle1: TextStyle(color: textColor),
        ),
        platform: TargetPlatform.iOS,
        primaryColor: darkColor,
        splashColor: darkColor,
        fontFamily: 'Montserrat',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: textColor,
            fontSize: 20,
            fontFamily: 'Pacifico',
          ),
        ),
        scaffoldBackgroundColor: darkerColor,
      ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      builder: EasyLoading.init(),
    );
  }
}

const darkerColor = Color(0xff082032);
const darkColor = Color(0xff2C394B);
const mediumColor = Color(0xff7B6CF6);
const lightColor = Color(0xffE5A5FF);
const textColor = Colors.white;
