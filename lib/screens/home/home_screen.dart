import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:iotee/core/constants.dart';
import 'package:iotee/core/route.dart';
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
  final btService = IoteeBluetoothService();
  Color pickedColor = Colors.pink;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    btService.init(widget.device, initFailedCallback: () {
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

  Future<void> toggleEnabled() => btService.sendMessageWithLoading(
        TOGGLE_ON_OFF,
        callback: _resetPickedColor,
      );

  Future<void> changeColor() => btService.sendMessageWithLoading(
        CHANGE_COLOR,
        callback: _resetPickedColor,
      );

  Future<void> slowRainbowMode() => btService.sendMessageWithLoading(
        SLOW_RAINBOW_MODE,
        callback: _resetPickedColor,
      );

  Future<void> showColorPicker(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromARGB(245, 245, 245, 245),
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

    //todo pwm
  }

  void _resetPickedColor() {
    setState(() {
      pickedColor = Colors.pink;
    });
  }

  @override
  Widget build(BuildContext context) => HomeWidgetView(this);
}
