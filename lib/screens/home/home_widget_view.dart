import 'package:flutter/material.dart';
import 'package:iotee/screens/home/home_screen.dart';

class HomeWidgetView extends StatelessWidget {
  final HomeScreenSate state;

  const HomeWidgetView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("aa"),
      ),
    );
  }
}
