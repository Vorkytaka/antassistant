import 'package:antassistant/utils/consts.dart';
import 'package:antassistant/utils/size.dart';
import 'package:flutter/material.dart';

EdgeInsets responsiveHorizontalEdgeInsets(MediaQueryData data) =>
    EdgeInsets.symmetric(horizontal: responsiveHorizontalPadding(data));

double responsiveHorizontalPadding(MediaQueryData data) {
  switch (data.windowSize) {
    case WindowSize.compact:
      return horizontalPadding;
    case WindowSize.medium:
      return data.size.width / 4;
    case WindowSize.expanded:
      return data.size.width / 3;
  }
}
