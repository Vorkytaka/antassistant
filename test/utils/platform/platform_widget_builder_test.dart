import 'package:antassistant/utils/platform/platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('TargetPlatform.android build by material builder',
      (WidgetTester tester) async {
    await tester.pumpWidget(_fullBuilder(TargetPlatform.android));
    final result = find.text('material');
    expect(result, findsOneWidget);
  });

  testWidgets('TargetPlatform.iOS build by cupertino builder',
      (WidgetTester tester) async {
    await tester.pumpWidget(_fullBuilder(TargetPlatform.iOS));
    final result = find.text('cupertino');
    expect(result, findsOneWidget);
  });

  testWidgets('TargetPlatform.macOS build by macOs builder',
      (WidgetTester tester) async {
    await tester.pumpWidget(_fullBuilder(TargetPlatform.macOS));
    final result = find.text('macOS');
    expect(result, findsOneWidget);
  });

  testWidgets('TargetPlatform.windows build by windows builder',
      (WidgetTester tester) async {
    await tester.pumpWidget(_fullBuilder(TargetPlatform.windows));
    final result = find.text('windows');
    expect(result, findsOneWidget);
  });

  testWidgets('TargetPlatform.linux build by linux builder',
      (WidgetTester tester) async {
    await tester.pumpWidget(_fullBuilder(TargetPlatform.linux));
    final result = find.text('linux');
    expect(result, findsOneWidget);
  });

  testWidgets('TargetPlatform.fuchsia build by fuchsia builder',
      (WidgetTester tester) async {
    await tester.pumpWidget(_fullBuilder(TargetPlatform.fuchsia));
    final result = find.text('fuchsia');
    expect(result, findsOneWidget);
  });

  testWidgets(
      'TargetPlatform.macOS build by cupertino builder, when macOs builder is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(_minimumBuilder(TargetPlatform.macOS));
    final result = find.text('cupertino');
    expect(result, findsOneWidget);
  });

  testWidgets(
      'TargetPlatform.windows build by material builder, when windows builder is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(_minimumBuilder(TargetPlatform.windows));
    final result = find.text('material');
    expect(result, findsOneWidget);
  });

  testWidgets(
      'TargetPlatform.linux build by material builder, when linux builder is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(_minimumBuilder(TargetPlatform.linux));
    final result = find.text('material');
    expect(result, findsOneWidget);
  });

  testWidgets(
      'TargetPlatform.fuchsia build by material builder, when fuchsia builder is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(_minimumBuilder(TargetPlatform.fuchsia));
    final result = find.text('material');
    expect(result, findsOneWidget);
  });
}

Widget _fullBuilder(TargetPlatform platform) => MaterialApp(
      home: PlatformWidgetBuilder(
        material: (context) => const Text('material'),
        cupertino: (context) => const Text('cupertino'),
        macOs: (context) => const Text('macOS'),
        windows: (context) => const Text('windows'),
        linux: (context) => const Text('linux'),
        fuchsia: (context) => const Text('fuchsia'),
        // web: (context) => const Text('web'),
        targetPlatform: platform,
      ),
    );

Widget _minimumBuilder(TargetPlatform platform) => MaterialApp(
      home: PlatformWidgetBuilder(
        material: (context) => const Text('material'),
        cupertino: (context) => const Text('cupertino'),
        targetPlatform: platform,
      ),
    );
