import 'package:antassistant/app.dart';
import 'package:antassistant/launcher.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final launcherData = await LauncherData.fromUrlLauncher();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(App(
    launcherData: launcherData,
    sharedPreferences: sharedPreferences,
  ));
}
