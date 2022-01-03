import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ThemeHolder {
  const ThemeHolder._();

  // getter for hot reload
  static get light => ThemeData(
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
      );
}
