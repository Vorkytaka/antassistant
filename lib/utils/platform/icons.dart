import 'package:antassistant/utils/platform/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformIcons {
  const PlatformIcons._();

  static IconData get accountActive => defaultTargetPlatform.isCupertino
      ? CupertinoIcons.profile_circled
      : Icons.account_circle;

  static IconData get account => defaultTargetPlatform.isCupertino
      ? CupertinoIcons.profile_circled
      : Icons.account_circle_outlined;

  static IconData get settingsActive => defaultTargetPlatform.isCupertino
      ? CupertinoIcons.gear_solid
      : Icons.settings;

  static IconData get settings => defaultTargetPlatform.isCupertino
      ? CupertinoIcons.gear
      : Icons.settings_outlined;
}
