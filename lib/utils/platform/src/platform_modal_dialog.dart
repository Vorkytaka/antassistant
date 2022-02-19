import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform.dart';

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
    if (Theme.of(context).platform.isCupertino) {
      return CupertinoActionSheet(
        title: title,
        actions: actions,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          ListTile(
            title: title,
          ),
        if (actions != null) ...actions!,
      ],
    );
  }
}

class PlatformModalAction extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Widget? leading;
  final bool isDestructiveAction;

  const PlatformModalAction({
    Key? key,
    required this.child,
    required this.onPressed,
    this.leading,
    this.isDestructiveAction = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform.isCupertino) {
      return CupertinoActionSheetAction(
        child: child,
        onPressed: onPressed,
        isDestructiveAction: isDestructiveAction,
      );
    }

    return ListTile(
      title: child,
      onTap: onPressed,
      leading: leading,
    );
  }
}
