import 'package:flutter/material.dart';
import 'package:iotee/core/theme.dart';
import 'package:iotee/core/widgets/no_items_placeholder.dart';
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
        duration: const Duration(milliseconds: 600),
        child: state.scanning
            ? _SearchPage(key: UniqueKey())
            : _LoadedPage(state, key: UniqueKey()),
      ),
    );
  }
}

class _SearchPage extends StatelessWidget {
  const _SearchPage({super.key});

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

  const _LoadedPage(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: state.flutterBlue.scanResults.map(
        (event) => event
            .where((element) => element.device.name.contains("HM"))
            .toList(),
      ),
      builder: (context, snapshot) {
        final items = snapshot.data;

        return items == null || items.isEmpty
            ? NoItemsPlaceholder(onSearchTapped: state.startScanning)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Title(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final device = items[index].device;

                        return _ListTile(
                          onTap: () => state.connect(device),
                          title: device.name,
                          subtitle: "ID: ${device.id.id}",
                        );
                      },
                    ),
                  )
                ],
              );
      },
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Hey!",
            style: TextStyle(fontSize: 34, color: textColor),
          ),
          SizedBox(height: 12),
          Text(
            "Here's what I found: ",
            style: TextStyle(fontSize: 24, color: textColor),
          ),
        ],
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function()? onTap;

  const _ListTile({this.onTap, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Material(
        child: InkWell(
          splashFactory: InkSplash.splashFactory,
          onTap: onTap,
          child: Container(
              color: darkColor,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: textColor),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                    child: const Icon(
                      Icons.bluetooth_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
