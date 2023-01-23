import 'package:flutter/material.dart';

//Local color palette (partial)
const darkerColor = Color(0xff082032);
const darkColor = Color(0xff2C394B);
const textColor = Colors.white;

final ioteeThemeData = ThemeData(
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
);
