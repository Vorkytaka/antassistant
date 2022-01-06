import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ThemeHolder {
  const ThemeHolder._();

  // getter for hot reload
  static get light => ThemeData(
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
          builders: {
            TargetPlatform.android: SharedAxisPageTransitionsBuilder(
              transitionType: SharedAxisTransitionType.vertical,
            ),
          },
        ),
      );

  static get dark => ThemeData(
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
          builders: {
            TargetPlatform.android: SharedAxisPageTransitionsBuilder(
              transitionType: SharedAxisTransitionType.vertical,
            ),
          },
        ),
      );
}
