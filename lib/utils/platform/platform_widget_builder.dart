import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformWidgetBuilder extends StatelessWidget {
  final WidgetBuilder material;
  final WidgetBuilder cupertino;
  final WidgetBuilder? macOs;
  final WidgetBuilder? windows;
  final WidgetBuilder? linux;
  final WidgetBuilder? fuchsia;
  final WidgetBuilder? web;
  final TargetPlatform? targetPlatform;

  const PlatformWidgetBuilder({
    Key? key,
    required this.material,
    required this.cupertino,
    this.macOs,
    this.windows,
    this.linux,
    this.fuchsia,
    this.web,
    this.targetPlatform,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (web != null && kIsWeb) {
      return web!(context);
    }

    final platform = targetPlatform ?? Theme.of(context).platform;

    switch (platform) {
      case TargetPlatform.android:
        return material(context);
      case TargetPlatform.fuchsia:
        return fuchsia != null ? fuchsia!(context) : material(context);
      case TargetPlatform.iOS:
        return cupertino(context);
      case TargetPlatform.linux:
        return linux != null ? linux!(context) : material(context);
      case TargetPlatform.macOS:
        return macOs != null ? macOs!(context) : cupertino(context);
      case TargetPlatform.windows:
        return windows != null ? windows!(context) : material(context);
    }
  }
}
