import 'package:flutter/material.dart';
import 'package:furever_home/app/app.dart';
import 'package:furever_home/app/di/di.dart';
import 'package:furever_home/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  await HiveService().init();

  runApp(
    const App(),
  );
}
