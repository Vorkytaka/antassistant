import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_widget_builder.dart';

class PlatformModalDialog extends StatelessWidget {
  final Widget? title;
  final List<Widget>? actions;

  const PlatformModalDialog({
    Key? key,
    this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidgetBuilder(
      material: (context) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              ListTile(
                title: title,
              ),
            if (actions != null) ...actions!,
          ],
        ),
      ),
      cupertino: (context) => CupertinoActionSheet(
        title: title,
        actions: actions,
      ),
    );
  }
}

class PlatformModalAction extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Widget? leading;
  final Widget? trailing;
  final bool isDestructiveAction;
  final bool isDefaultAction;

  const PlatformModalAction({
    Key? key,
    required this.child,
    required this.onPressed,
    this.leading,
    this.trailing,
    this.isDestructiveAction = false,
    this.isDefaultAction = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidgetBuilder(
      material: (context) => ListTile(
        title: child,
        onTap: onPressed,
        leading: leading,
        trailing: trailing,
      ),
      cupertino: (context) => CupertinoActionSheetAction(
        child: child,
        onPressed: onPressed,
        isDestructiveAction: isDestructiveAction,
        isDefaultAction: isDefaultAction,
      ),
    );
  }
}
