import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iotee/core/route.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _initLoading();

    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) async {
      if (status != AnimationStatus.completed) return;

      await checkNeededPermissions();
      context.router.replace(const ScanRoute());
    });
  }

  Future<void> checkNeededPermissions() async {
    final bluetooth = await Permission.bluetooth.status;

    if (Platform.isAndroid) await _checkAndroidPermissions();

    if (bluetooth.isDenied) {
      await Permission.bluetooth.request();
    }
  }

  //Android needs Location Permission in order to use Bluetooth
  Future<void> _checkAndroidPermissions() async {
    final location = await Permission.location.status;
    final locationWhenInUse = await Permission.locationWhenInUse.status;

    if (location.isDenied) {
      await Permission.location.request();
    }

    if (locationWhenInUse.isDenied) {
      await Permission.locationWhenInUse.request();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _initLoading() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorWidget = Lottie.asset('assets/loading.json')
      ..maskType = EasyLoadingMaskType.custom
      ..maskColor = Colors.white.withOpacity(0.4)
      ..indicatorType = EasyLoadingIndicatorType.pulse
      ..dismissOnTap = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/splash-logo.json',
          width: 200,
          height: 200,
          controller: _controller,
          onLoaded: (localController) {
            _controller
              ..duration = localController.duration
              ..forward();
          },
        ),
      ),
    );
  }
}
