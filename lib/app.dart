import 'package:antassistant/data/repository.dart';
import 'package:antassistant/domain/credentials/credentials_bloc.dart';
import 'package:antassistant/generated/l10n.dart';
import 'package:antassistant/theme.dart';
import 'package:antassistant/ui/login/login_screen.dart';
import 'package:antassistant/ui/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dependencies(
      child: MaterialApp(
        title: 'ANTAssistant',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate,
        ],
        routes: const {
          MainScreen.path: MainScreen.builder,
          LoginScreen.path: LoginScreen.builder,
        },
        initialRoute: MainScreen.path,
        theme: ThemeHolder.light,
      ),
    );
  }
}

class Dependencies extends StatelessWidget {
  final Widget child;

  const Dependencies({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Repository>(
      create: (context) => MockRepository(),
      child: BlocProvider<CredentialsBloc>(
        create: (context) => CredentialsBloc(repository: context.read()),
        lazy: false,
        child: child,
      ),
    );
  }
}
