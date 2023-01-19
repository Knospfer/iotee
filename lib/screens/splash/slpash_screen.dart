import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iotee/core/route.dart';
import 'package:lottie/lottie.dart';

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

    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status != AnimationStatus.completed) return;
      context.router.replace(const HomeRoute());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
