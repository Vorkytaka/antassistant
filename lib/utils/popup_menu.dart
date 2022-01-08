import 'package:flutter/material.dart';

class PopupMenuVerticalPadding extends PopupMenuEntry<Never> {
  static const double _kDefaultPadding = 4;

  /// Creates a horizontal divider for a popup menu.
  ///
  /// By default, the divider has a height of 4 logical pixels.
  const PopupMenuVerticalPadding({Key? key, this.height = _kDefaultPadding})
      : super(key: key);

  /// The height of the divider entry.
  ///
  /// Defaults to 4 pixels.
  @override
  final double height;

  @override
  bool represents(void value) => false;

  @override
  State<PopupMenuVerticalPadding> createState() =>
      _PopupMenuVerticalPaddingState();
}

class _PopupMenuVerticalPaddingState extends State<PopupMenuVerticalPadding> {
  @override
  Widget build(BuildContext context) => SizedBox(height: widget.height);
}
