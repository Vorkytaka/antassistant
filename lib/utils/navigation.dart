import 'package:flutter/material.dart';

// Signature for function that validate if [AutoPopRoute] should remove itself
typedef PopValidator = bool Function(BuildContext context);

// Route that will auto-removes itself if the validator return true
class AutoPopRoute<T> extends MaterialPageRoute<T> {
  final PopValidator validator;
  final VoidCallback? onAutoPop;

  AutoPopRoute({
    required WidgetBuilder builder,
    required this.validator,
    this.onAutoPop,
  }) : super(builder: builder);

  @override
  Widget buildContent(BuildContext context) {
    if (validator(context)) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        navigator?.removeRoute(this);
        onAutoPop?.call();
      });
    }
    return super.buildContent(context);
  }
}
