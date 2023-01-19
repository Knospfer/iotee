import 'package:flutter/material.dart';
import 'package:iotee/screens/scan_screen/scan_screen.dart';
import 'package:lottie/lottie.dart';

class ScanWidgetView extends StatelessWidget {
  final ScanScreenState state;

  const ScanWidgetView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IoTee')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: state.scanning ? _SearchPage() : _LoadedPage(state),
      ),
    );
  }
}

class _SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/bluetooth-loading.json',
            height: 200,
            width: 200,
          ),
          const SizedBox(height: 8),
          const Text("Searching Devices.."),
        ],
      ),
    );
  }
}

class _LoadedPage extends StatelessWidget {
  final ScanScreenState state;

  const _LoadedPage(this.state);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () => state.connect(state.items[index]),
        title: Text(state.items[index]),
      ),
      itemCount: state.items.length,
    );
  }
}
