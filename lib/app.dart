import 'package:flutter/material.dart';
import 'package:furever_home/core/app_theme/app_theme.dart';
import 'package:furever_home/view/dashboard_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DashboardView(),
      theme: getApplicationTheme(),
    );
  }
}
