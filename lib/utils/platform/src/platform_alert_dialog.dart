import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform.dart';

class PlatformAlertDialog extends StatelessWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? content;

  const PlatformAlertDialog({
    Key? key,
    this.title,
    this.actions,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform.isCupertino) {
      return CupertinoAlertDialog(
        title: title,
        actions: actions ?? const [],
        content: content,
      );
    }

    return AlertDialog(
      title: title,
      actions: actions,
      content: content,
    );
  }
}

class PlatformAlertDialogAction extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final bool isDestructiveAction;

  const PlatformAlertDialogAction({
    Key? key,
    required this.onPressed,
    required this.child,
    this.style,
    this.isDestructiveAction = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform.isCupertino) {
      return CupertinoDialogAction(
        child: child,
        onPressed: onPressed,
        isDestructiveAction: isDestructiveAction,
      );
    }

    return TextButton(
      onPressed: onPressed,
      child: child,
      style: style,
    );
  }
}
