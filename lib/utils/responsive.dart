import 'package:antassistant/utils/platform/platform.dart';
import 'package:antassistant/utils/size.dart';
import 'package:flutter/material.dart';

class ResponsiveScaffold extends StatelessWidget {
  final List<ResponsiveDestination>? destinations;
  final Widget? body;
  final bool? resizeToAvoidBottomInset;
  final PreferredSizeWidget? appBar;

  const ResponsiveScaffold({
    Key? key,
    this.destinations,
    this.body,
    this.resizeToAvoidBottomInset,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final isCompact = data.windowSize == WindowSize.compact;

    final actualBody = isCompact || destinations == null
        ? body
        : Row(
            children: [
              NavigationRail(
                destinations: destinations!
                    .map((e) => e._navRail)
                    .toList(growable: false),
                selectedIndex: 0,
              ),
              Expanded(child: body ?? const SizedBox()),
            ],
          );

    final navBar = !isCompact && destinations != null
        ? null
        : PlatformBottomNavigationBar(
            currentIndex: 0,
            items: destinations!.map((e) => e._navBar).toList(growable: false),
          );

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar,
      body: actualBody,
      bottomNavigationBar: navBar,
    );
  }
}

class ResponsiveDestination {
  final Widget icon;
  final Widget? activeIcon;
  final String label;

  const ResponsiveDestination({
    required this.icon,
    this.activeIcon,
    required this.label,
  });

  BottomNavigationBarItem get _navBar => BottomNavigationBarItem(
        icon: icon,
        activeIcon: activeIcon,
        label: label,
      );

  NavigationRailDestination get _navRail => NavigationRailDestination(
        icon: icon,
        selectedIcon: activeIcon,
        label: Text(label),
      );
}
