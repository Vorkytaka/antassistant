import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'platform.dart';

class PlatformIcons {
  const PlatformIcons._();

  static IconData get accountActive => defaultTargetPlatform.isCupertino
      ? CupertinoIcons.profile_circled
      : Icons.account_circle;

  // It's can be useful in case, when we want to check theme's platform
  // instead of default one
  //
  // static IconData getAccountActive([BuildContext? context]) {
  //   return _isCupertino(context)
  //       ? CupertinoIcons.profile_circled
  //       : Icons.account_circle;
  // }

  static IconData get account => defaultTargetPlatform.isCupertino
      ? CupertinoIcons.profile_circled
      : Icons.account_circle_outlined;

  static IconData get settingsActive => defaultTargetPlatform.isCupertino
      ? CupertinoIcons.gear_solid
      : Icons.settings;

  static IconData get settings => defaultTargetPlatform.isCupertino
      ? CupertinoIcons.gear
      : Icons.settings_outlined;

  static _isCupertino([BuildContext? context]) => context != null
      ? Theme.of(context).platform.isCupertino
      : defaultTargetPlatform.isCupertino;
}
