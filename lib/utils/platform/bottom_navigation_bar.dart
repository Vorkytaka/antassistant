import 'package:antassistant/utils/platform/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final Color? backgroundColor;
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const PlatformBottomNavigationBar({
    Key? key,
    required this.items,
    this.backgroundColor,
    this.currentIndex = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform.isCupertino) {
      return CupertinoTabBar(
        items: items,
        backgroundColor: backgroundColor,
        currentIndex: currentIndex,
        onTap: onTap,
      );
    }

    return BottomNavigationBar(
      items: items,
      backgroundColor: backgroundColor,
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
