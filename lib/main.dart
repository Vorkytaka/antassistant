import 'package:antassistant/app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Disgusting way to handle it
// todo: use InheritedWidget
// also todo: need to check all url_launcher things (like browser)
late final bool canPhone;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  canPhone = await canLaunch('tel:+7-495-940-92-11').onError((_, __) => false);
  runApp(const App());
}
