import 'package:flutter/material.dart';
import 'package:iotee/core/widgets/iotee_button.dart';
import 'package:iotee/screens/home/home_screen.dart';
import 'package:lottie/lottie.dart';

class HomeWidgetView extends StatelessWidget {
  final HomeScreenSate state;

  const HomeWidgetView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _FilledView(this),
      floatingActionButton: FloatingActionButton(
        onPressed: state.toggleEnabled,
        child: const Icon(Icons.power_settings_new),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  final HomeWidgetView parent;

  const _EmptyView(this.parent);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/empty-box.json',
            height: 200,
            width: 200,
            repeat: false,
          ),
          const Text("No connected items found!"),
          TextButton(onPressed: () {}, child: const Text("Seach!")),
        ],
      ),
    );
  }
}

class _FilledView extends StatelessWidget {
  final HomeWidgetView parent;

  const _FilledView(this.parent);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('IoTee'),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                .copyWith(top: 36),
            child: IoteeButton(
              label: "Change color!",
              onTap: parent.state.changeColor,
              // enabled: parent.state.enabled,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: IoteeButton(
              label: "Rainbow mode",
              onTap: parent.state.slowRainbowMode,
              // enabled: parent.state.enabled,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: IoteeButton(
              label: "Custom color",
              backgroundColor: parent.state.pickedColor,
              onTap: () => parent.state.showColorPicker(context),
              // enabled: parent.state.enabled,
            ),
          ),
        ),
      ],
    );
  }
}
