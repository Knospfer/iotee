import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iotee/core/route.dart';
import 'package:iotee/screens/scan_screen/scan_widget_view.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => ScanScreenState();
}

class ScanScreenState extends State<ScanScreen> {
  final flutterBlue = FlutterBluePlus.instance;
  bool scanning = false;

  late final StreamSubscription subscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    subscription = flutterBlue.scanResults.listen((results) {
      if (results.isEmpty) return;
      setState(() {
        scanning = false;
      });
    });

    startScanning();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  Future<void> startScanning() async {
    setState(() {
      scanning = true;
    });
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    //aggiorno la grafica se non ho trovato niente
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      scanning = false;
    });
  }

  Future<void> connect(String item) async {
    await _handleWithLoadings(() async => Future.delayed(Duration(seconds: 2)));
    context.router.replace(const HomeRoute());
  }

  Future<void> _handleWithLoadings(Future Function() callback) async {
    EasyLoading.show();
    try {
      await callback();
      await EasyLoading.dismiss();
      await EasyLoading.showToast(
        "Success!",
        toastPosition: EasyLoadingToastPosition.bottom,
        maskType: EasyLoadingMaskType.none,
      );
    } catch (_) {
      await EasyLoading.showError("Error");
    }
  }

  @override
  Widget build(BuildContext context) => ScanWidgetView(this);
}
