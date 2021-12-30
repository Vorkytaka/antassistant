import 'package:flutter/material.dart';

abstract class ThemeHolder {
  const ThemeHolder._();

  // getter for hot reload
  static get light => ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
        ),
      );
}
