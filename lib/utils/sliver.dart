import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef KeyWidgetBuilder<K> = Widget Function(
  BuildContext context,
  K key,
);

int _kDefaultSemanticIndexCallback(Widget _, int localIndex) => localIndex;

Widget _createErrorWidget(Object exception, StackTrace stackTrace) {
  final FlutterErrorDetails details = FlutterErrorDetails(
    exception: exception,
    stack: stackTrace,
    library: 'widgets library',
    context: ErrorDescription('building'),
  );
  FlutterError.reportError(details);
  return ErrorWidget.builder(details);
}

class _SaltedValueKey extends ValueKey<Key> {
  const _SaltedValueKey(Key key) : super(key);
}

class SliverChildMapBuilderDelegate<K> extends SliverChildDelegate {
  const SliverChildMapBuilderDelegate(
    this.builder,
    this.keys, {
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticIndexCallback = _kDefaultSemanticIndexCallback,
    this.semanticIndexOffset = 0,
  });

  final KeyWidgetBuilder<K> builder;
  final List<K> keys;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final int semanticIndexOffset;
  final SemanticIndexCallback semanticIndexCallback;

  @override
  Widget? build(BuildContext context, int index) {
    if (index < 0 || (index >= keys.length)) {
      return null;
    }

    Widget? child;
    try {
      child = builder(context, keys[index]);
    } catch (exception, stackTrace) {
      child = _createErrorWidget(exception, stackTrace);
    }

    final Key? key = child.key != null ? _SaltedValueKey(child.key!) : null;

    if (addRepaintBoundaries) {
      child = RepaintBoundary(child: child);
    }

    if (addSemanticIndexes) {
      final int? semanticIndex = semanticIndexCallback(child, index);
      if (semanticIndex != null) {
        child = IndexedSemantics(
            index: semanticIndex + semanticIndexOffset, child: child);
      }
    }

    if (addAutomaticKeepAlives) {
      child = AutomaticKeepAlive(child: child);
    }

    return KeyedSubtree(key: key, child: child);
  }

  @override
  bool shouldRebuild(covariant SliverChildDelegate oldDelegate) => true;

  @override
  int? get estimatedChildCount => keys.length;
}

extension ListViewMap on ListView {
  static Widget mapBuilder<K>({
    required KeyWidgetBuilder<K> builder,
    required Iterable<K> keys,
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
  }) =>
      ListView.custom(
        key: key,
        childrenDelegate: SliverChildMapBuilderDelegate<K>(
          builder,
          keys.toList(growable: false),
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
        scrollDirection: scrollDirection,
        reverse: reverse,
        controller: controller,
        primary: primary,
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: padding,
        cacheExtent: cacheExtent,
        semanticChildCount: semanticChildCount,
        dragStartBehavior: dragStartBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        restorationId: restorationId,
        clipBehavior: clipBehavior,
      );

/*static Widget mapSeparated<K>({
    required KeyWidgetBuilder<K> builder,
    required KeyWidgetBuilder<K> separatorBuilder,
    required Iterable<K> keys,
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
  }) =>
      ListView.custom(
        key: key,
        childrenDelegate: SliverChildMapBuilderDelegate<K>(
          builder,
          keys.toList(growable: false),
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
        scrollDirection: scrollDirection,
        reverse: reverse,
        controller: controller,
        primary: primary,
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: padding,
        cacheExtent: cacheExtent,
        semanticChildCount: semanticChildCount,
        dragStartBehavior: dragStartBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        restorationId: restorationId,
        clipBehavior: clipBehavior,
      );*/
}
