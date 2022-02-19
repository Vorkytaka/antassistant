import 'package:flutter/widgets.dart';

extension PlatformUtils on TargetPlatform {
  bool get isCupertino =>
      this == TargetPlatform.iOS || this == TargetPlatform.macOS;
}
