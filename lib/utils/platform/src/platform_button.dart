import 'package:antassistant/utils/platform/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool _primary;

  const PlatformButton.primary({
    Key? key,
    required this.onPressed,
    required this.child,
  })  : _primary = true,
        super(key: key);

  const PlatformButton.secondary({
    Key? key,
    required this.onPressed,
    required this.child,
  })  : _primary = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final WidgetBuilder material;
    final WidgetBuilder cupertino;
    if (_primary) {
      material = (context) => ElevatedButton(
            onPressed: onPressed,
            child: child,
          );
      cupertino = (context) => CupertinoButton.filled(
            onPressed: onPressed,
            child: child,
          );
    } else {
      material = (context) => OutlinedButton(
            onPressed: onPressed,
            child: child,
          );
      cupertino = (context) => CupertinoButton(
            onPressed: onPressed,
            child: child,
          );
    }

    return PlatformWidgetBuilder(
      material: material,
      cupertino: cupertino,
    );
  }
}
