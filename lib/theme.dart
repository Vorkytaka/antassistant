import 'package:animations/animations.dart';
import 'package:antassistant/utils/platform/platform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ThemeHolder {
  const ThemeHolder._();

  // getter for hot reload
  static light({TargetPlatform? platform}) => ThemeData(
        platform: platform,
        brightness: Brightness.light,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          actionsIconTheme: const IconThemeData.fallback(),
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          titleTextStyle: Typography.material2018()
              .black
              .merge(Typography.englishLike2018)
              .headline6,
          toolbarTextStyle: Typography.material2018()
              .black
              .merge(Typography.englishLike2018)
              .bodyText2,
          iconTheme: const IconThemeData.fallback(),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: transitionsBuilders,
        ),
        splashFactory:
            defaultTargetPlatform.isCupertino ? NoSplash.splashFactory : null,
      );

  static dark({TargetPlatform? platform}) => ThemeData(
        platform: platform,
        brightness: Brightness.dark,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: transitionsBuilders,
        ),
        splashFactory:
            defaultTargetPlatform.isCupertino ? NoSplash.splashFactory : null,
        selectedRowColor: Colors.grey[700],
      );

  static const transitionsBuilders = {
    TargetPlatform.android: SharedAxisPageTransitionsBuilder(
      transitionType: SharedAxisTransitionType.vertical,
    ),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
  };
}
