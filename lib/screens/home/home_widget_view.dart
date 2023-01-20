import 'package:flutter/material.dart';
import 'package:iotee/core/widgets/iotee_button.dart';
import 'package:iotee/core/widgets/no_items_placeholder.dart';
import 'package:iotee/screens/home/home_screen.dart';

class HomeWidgetView extends StatelessWidget {
  final HomeScreenSate state;

  const HomeWidgetView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: state.isEmpty
            ? _EmptyView(this, key: UniqueKey())
            : _FilledView(this, key: UniqueKey()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: state.toggleEnabled,
        child: const Icon(Icons.power_settings_new),
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
