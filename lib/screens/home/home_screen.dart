import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:iotee/screens/home/home_widget_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenSate();
}

class HomeScreenSate extends State<HomeScreen> {
  bool enabled = true;
  Color pickedColor = Colors.pink; //TODO QUANDO TAPPO ALTRI TASTI RESETTA

  void toggleEnabled() {
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

  @override
  Widget build(BuildContext context) => HomeWidgetView(this);
}
