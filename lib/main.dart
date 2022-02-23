import 'package:antassistant/app.dart';
import 'package:antassistant/launcher.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final launcherData = await LauncherData.fromUrlLauncher();
  runApp(App(launcherData: launcherData));
}
