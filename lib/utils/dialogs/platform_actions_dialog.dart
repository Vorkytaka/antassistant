import 'package:antassistant/utils/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformActionsDialog extends StatelessWidget {
  final Widget title;
  final List<PlatformDialogAction> actions;

  const PlatformActionsDialog({
    Key? key,
    required this.title,
    required this.actions,
  })  : assert(actions.length >= 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform.isCupertino) {
      return CupertinoAlertDialog(
        title: title,
        actions: actions,
      );
    }

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 18,
        bottom: 18,
      ),
      title: title,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: actions,
      ),
    );
  }
}

class PlatformDialogAction extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final bool isDestructiveAction;

  const PlatformDialogAction({
    Key? key,
    required this.child,
    this.onPressed,
    this.leading,
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

    return ListTile(
      title: child,
      onTap: onPressed,
      leading: leading,
    );
  }
}
