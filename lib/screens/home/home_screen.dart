import 'package:flutter/material.dart';
import 'package:iotee/screens/home/home_widget_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenSate();
}

class HomeScreenSate extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => HomeWidgetView(this);
}