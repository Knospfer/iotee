import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iotee/screens/home/home_screen.dart';
import 'package:iotee/screens/scan_screen/scan_screen.dart';
import 'package:iotee/screens/splash/slpash_screen.dart';

part 'route.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: HomeScreen),
    AutoRoute(page: ScanScreen),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
