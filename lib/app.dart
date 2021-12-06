import 'package:antassistant/generated/l10n.dart';
import 'package:antassistant/ui/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ANTAssistant',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      routes: {
        MainScreen.path: MainScreen.builder,
      },
      initialRoute: MainScreen.path,
    );
  }
}
