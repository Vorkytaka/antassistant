import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherData {
  final bool phone;
  final bool web;

  const LauncherData({
    required this.phone,
    required this.web,
  });

  static Future<LauncherData> fromUrlLauncher() async {
    return LauncherData(
      phone: await canLaunch(Launcher.phoneUri),
      web: await canLaunch(Launcher.siteUri),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is LauncherData && phone == other.phone && web == other.web;

  @override
  int get hashCode => hashValues(phone, web);
}

class Launcher extends InheritedWidget {
  static const String phoneUri = 'tel:+7-495-940-92-11';
  static const String siteUri = 'http://a-n-t.ru/';

  final LauncherData data;

  const Launcher({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(Launcher oldWidget) => data != oldWidget.data;

  static LauncherData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Launcher>()!.data;

  // check possibility?
  static Future<bool> phone(BuildContext context) => launch(phoneUri);

  // check possibility?
  static Future<bool> site(BuildContext context) => launch(siteUri);
}
