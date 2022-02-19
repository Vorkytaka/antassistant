import 'package:antassistant/utils/platform/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformFilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const PlatformFilledButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidgetBuilder(
      material: (context) => ElevatedButton(
        onPressed: onPressed,
        child: child,
      ),
      cupertino: (context) => CupertinoButton.filled(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
