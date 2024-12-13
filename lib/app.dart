import 'package:flutter/material.dart';
import 'package:furever_home/view/login_view.dart';
import 'package:furever_home/view/onboard_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardView(),
    );
  }
}
