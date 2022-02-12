import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension PlatformUtils on TargetPlatform {
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

Future<T?> showPlatformModalSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
}) async {
  if (Theme.of(context).platform.isCupertino) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: builder,
      barrierDismissible: barrierDismissible,
    );
  }

  return showModalBottomSheet(
    context: context,
    builder: builder,
    isDismissible: barrierDismissible,
  );
}

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
