import 'package:antassistant/generated/l10n.dart';
import 'package:flutter/material.dart';

extension ThemeModeIntl on ThemeMode {
  String intl(BuildContext context) {
    switch(this) {
      case ThemeMode.system:
        return S.of(context).common__theme_system;
      case ThemeMode.light:
        return S.of(context).common__theme_light;
      case ThemeMode.dark:
        return S.of(context).common__theme_dark;
    }
  }
}