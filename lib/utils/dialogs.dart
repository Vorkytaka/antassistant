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

  const PlatformModalAction({
    Key? key,
    required this.child,
    required this.onPressed,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform.isCupertino) {
      return CupertinoActionSheetAction(
        child: child,
        onPressed: onPressed,
      );
    }

    return ListTile(
      title: child,
      onTap: onPressed,
      leading: leading,
    );
  }
}


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

  const PlatformDialogAction({
    Key? key,
    required this.child,
    this.onPressed,
    this.leading,
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
      leading: leading,
    );
  }
}
