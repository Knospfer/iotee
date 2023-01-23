import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:iotee/core/constants.dart';
import 'package:iotee/core/route.dart';
import 'package:iotee/core/theme.dart';
import 'package:iotee/non_functional_requirements/bluetooth_service.dart';
import 'package:iotee/screens/home/home_widget_view.dart';

class HomeScreen extends StatefulWidget {
  final BluetoothDevice device;
  const HomeScreen({super.key, required this.device});

  @override
  State<StatefulWidget> createState() => HomeScreenSate();
}

class HomeScreenSate extends State<HomeScreen> {
  bool isEmpty = false;
  bool isBluetoothRequestRunning = false;

  final btService = IoteeBluetoothMessagingService();
  Color pickedColor = darkColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    btService.init(widget.device, initFailedCallback: () {
      //If some characteristic are missing return to search page
      setState(() {
        isEmpty = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.device.disconnect();
  }

  void navigateToSearch() {
    context.router.replace(const ScanRoute());
  }

  Future<void> toggleEnabled() => _toggleButtonsWhenRequestIsRunning(
        request: () => btService.sendMessage(TOGGLE_ON_OFF),
      );

  Future<void> changeColor() => _toggleButtonsWhenRequestIsRunning(
        request: () => btService.sendMessage(CHANGE_COLOR),
      );

  Future<void> slowRainbowMode() => _toggleButtonsWhenRequestIsRunning(
        request: () => btService.sendMessage(SLOW_RAINBOW_MODE),
      );

  Future<void> customColorMode(BuildContext context) =>
      _toggleButtonsWhenRequestIsRunning(
        request: () async {
          await _showColorPicker(context);
          final customColorMessage =
              "$CUSTOM_COLOR ${pickedColor.red} ${pickedColor.green} ${pickedColor.blue} 0";
          // await btService.sendMessageWithLoading(customColorMessage) //MARCO: scommenta questa riga per abilitare la chiamata a PWM
        },
      );

  Future<void> _showColorPicker(BuildContext context) => showModalBottomSheet(
        context: context,
        backgroundColor: darkColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (_) => ColorPicker(
          pickerColor: pickedColor,
          paletteType: PaletteType.hueWheel,
          onColorChanged: (value) {
            setState(() {
              pickedColor = value;
            });
          },
        ),
      );

  Future<void> _toggleButtonsWhenRequestIsRunning({
    required Future<void> Function() request,
  }) async {
    setState(() {
      isBluetoothRequestRunning = true;
    });
    await request();
    setState(() {
      isBluetoothRequestRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) => HomeWidgetView(this);
}
