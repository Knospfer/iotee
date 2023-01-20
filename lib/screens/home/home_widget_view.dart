import 'package:flutter/material.dart';
import 'package:iotee/core/widgets/no_items_placeholder.dart';
import 'package:iotee/screens/home/home_screen.dart';

class HomeWidgetView extends StatelessWidget {
  final HomeScreenSate state;

  const HomeWidgetView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IoTee')),
      body: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: state.isEmpty
            ? _EmptyView(this, key: UniqueKey())
            : _FilledView(this, key: UniqueKey()),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  final HomeWidgetView parent;

  const _EmptyView(this.parent, {Key? key});

  @override
  Widget build(BuildContext context) {
    return NoItemsPlaceholder(onSearchTapped: parent.state.navigateToSearch);
  }
}

class _FilledView extends StatelessWidget {
  final HomeWidgetView parent;

  const _FilledView(this.parent, {Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            parent.state.widget.device.name,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16).copyWith(top: 30),
          child: Row(
            children: [
              GestureDetector(
                onTap: parent.state.toggleEnabled,
                child: Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: ButtonStyle(),
                  child: const Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: GestureDetector(
                  onTap: parent.state.changeColor,
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: ButtonStyle(),
                    child: const Text("COLOR"),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onTap: parent.state.slowRainbowMode,
            child: Container(
              height: 200,
              alignment: Alignment.center,
              decoration: ButtonStyle(),
              child: const Text("RAINBOW"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onTap: () => parent.state.showColorPicker(context),
            child: Container(
              height: 60,
              alignment: Alignment.center,
              decoration: ButtonStyle(),
              child: const Text("CUSTOM"),
            ),
          ),
        ),
      ],
    );
  }
}

class ButtonStyle extends BoxDecoration {
  ButtonStyle()
      : super(
          borderRadius: const BorderRadius.all(Radius.circular(60)),
          border: Border.all(
            color: Colors.white,
          ),
        );
}
