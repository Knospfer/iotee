import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iotee/screens/home/home_widget_view.dart';

class HomeScreen extends StatefulWidget {
  final BluetoothDevice device;
  const HomeScreen({super.key, required this.device});

  @override
  State<StatefulWidget> createState() => HomeScreenSate();
}

class HomeScreenSate extends State<HomeScreen> {
  bool enabled = true;
  Color pickedColor = Colors.pink; //TODO QUANDO TAPPO ALTRI TASTI RESETTA

  @override
  void dispose() {
    super.dispose();
    widget.device.disconnect();
  }

  void changeColor() {
    _resetPickedColor();
  }

  void slowRainbowMode() {
    _resetPickedColor();
  }

  void fastRainbowMode() {
    _resetPickedColor();
  }

  void toggleEnabled() {
    _handleWithLoadings(() async {
      await Future.delayed(Duration(seconds: 1));

      _resetPickedColor();
    });

    setState(() {
      enabled = !enabled;
    });
  }

  void showColorPicker(BuildContext context) {
    showModalBottomSheet(
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
    //TODO QUA AGGIORNA BT
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

  void _resetPickedColor() {
    setState(() {
      pickedColor = Colors.pink;
    });
  }

  @override
  Widget build(BuildContext context) => HomeWidgetView(this);
}
