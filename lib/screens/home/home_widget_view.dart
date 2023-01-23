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
              _Button(
                width: 60,
                padding: EdgeInsets.zero,
                onTap: parent.state.toggleEnabled,
                isLoading: parent.state.isBluetoothRequestRunning,
                child: const Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _Button(
                  padding: EdgeInsets.zero,
                  onTap: () => parent.state.changeColor,
                  isLoading: parent.state.isBluetoothRequestRunning,
                  child: const Text("COLOR"),
                ),
              ),
            ],
          ),
        ),
        _Button(
          onTap: () => parent.state.slowRainbowMode,
          isLoading: parent.state.isBluetoothRequestRunning,
          height: 180,
          child: const Text("RAINBOW"),
        ),
        _Button(
          onTap: () => parent.state.customColorMode(context),
          isLoading: parent.state.isBluetoothRequestRunning,
          child: const Text("CUSTOM"),
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final void Function() onTap;
  final Widget child;
  final bool isLoading;
  final double height;
  final double? width;
  final EdgeInsets padding;

  const _Button({
    required this.onTap,
    required this.child,
    this.isLoading = false,
    this.width,
    this.height = 60,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(60));

    return IgnorePointer(
      ignoring: isLoading,
      child: Padding(
        padding: padding,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(borderRadius: borderRadius),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashFactory: InkRipple.splashFactory,
              onTap: onTap,
              child: Container(
                height: height,
                width: width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  border: Border.all(color: Colors.white),
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
