import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension on TargetPlatform {
  bool get isCupertino =>
      this == TargetPlatform.iOS || this == TargetPlatform.macOS;
}

Future<T?> showPlatformDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
}) async {
  if (Theme.of(context).platform.isCupertino) {
    return showCupertinoDialog<T>(
      context: context,
      builder: builder,
      barrierDismissible: barrierDismissible,
    );
  }

  return showDialog<T>(
    context: context,
    builder: builder,
    barrierDismissible: barrierDismissible,
  );
}

class PlatformActionsDialog extends StatelessWidget {
  final Widget? title;
  final List<PlatformDialogAction>? actions;

  const PlatformActionsDialog({
    Key? key,
    this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform.isCupertino) {
      return CupertinoAlertDialog(
        title: title,
        actions: actions ?? const [],
      );
    }

    return AlertDialog(
      title: title,
      actions: actions,
    );
  }
}

class PlatformDialogAction extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const PlatformDialogAction({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform.isCupertino) {
      return CupertinoDialogAction(
        child: child,
        onPressed: onPressed,
      );
    }

    return ListTile(
      title: child,
      onTap: onPressed,
    );
  }
}
