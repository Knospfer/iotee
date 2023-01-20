import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoItemsPlaceholder extends StatelessWidget {
  final void Function() onSearchTapped;

  const NoItemsPlaceholder({super.key, required this.onSearchTapped});

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
          TextButton(onPressed: onSearchTapped, child: const Text("Seach!")),
        ],
      ),
    );
  }
}
