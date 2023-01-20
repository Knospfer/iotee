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
    await flutterBlue.startScan(timeout: const Duration(seconds: 4));
    setState(() {
      scanning = false;
    });
  }

  Future<void> connect(BluetoothDevice device) => _handleWithLoadings(() async {
        await device.connect();
        context.router.replace(HomeRoute(device: device));
      });

  Future<void> _handleWithLoadings(Future Function() callback) async {
    EasyLoading.show();
    try {
      await callback();
      await EasyLoading.dismiss();
    } catch (_) {
      await EasyLoading.showError("Error");
    }
  }

  @override
  Widget build(BuildContext context) => ScanWidgetView(this);
}
