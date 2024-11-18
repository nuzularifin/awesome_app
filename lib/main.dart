import 'package:flutter/material.dart';
import 'package:flutter_awesome_app/presentation/dashboard/home_page_screen.dart';
import 'package:flutter_awesome_app/core/service_locator.dart' as di;

void main() {
  di.setup();
  runApp(const AwesomeApp());
}

class AwesomeApp extends StatelessWidget {
  const AwesomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageScreen(),
    );
  }
}
