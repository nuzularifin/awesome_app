import 'package:flutter/material.dart';
import 'package:flutter_awesome_app/presentation/dashboard/home_page_screen.dart';
import 'package:flutter_awesome_app/core/service_locator.dart' as di;
import 'package:flutter_awesome_app/themes/app_theme.dart';

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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: HomePageScreen(),
    );
  }
}
