import 'package:flutter/material.dart';

enum WindowSize {
  compact,
  medium,
  expanded,
}

extension MediaQuerySize on MediaQueryData {
  WindowSize get windowSize {
    final width = size.width;
    if (width < 600) {
      return WindowSize.compact;
    } else if (width < 840 || isPhone) {
      return WindowSize.medium;
    } else {
      return WindowSize.expanded;
    }
  }

  bool get isPhone => size.shortestSide < 600;
}

extension BoxConstraintsSize on BoxConstraints {
  WindowSize get windowSize {
    final width = maxWidth;
    if (width < 600) {
      return WindowSize.compact;
    } else if (width < 840) {
      return WindowSize.medium;
    } else {
      return WindowSize.expanded;
    }
  }
}
