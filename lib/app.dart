import 'package:antassistant/data/dao/credentials_dao.dart';
import 'package:antassistant/data/repository.dart';
import 'package:antassistant/data/repository_impl.dart';
import 'package:antassistant/data/service/service.dart';
import 'package:antassistant/domain/accounts/accounts_bloc.dart';
import 'package:antassistant/generated/l10n.dart';
import 'package:antassistant/theme.dart';
import 'package:antassistant/ui/details/details_screen.dart';
import 'package:antassistant/ui/login/login_screen.dart';
import 'package:antassistant/ui/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ANTAssistant',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      routes: const {
        HomeScreen.path: HomeScreen.builder,
        LoginScreen.path: LoginScreen.builder,
      },
      onGenerateRoute: (settings) {
        if (settings.name == DetailsScreen.path) {
          final String name = settings.arguments as String;
          return MaterialPageRoute(
              builder: (context) => DetailsScreen.builder(context, name));
        }
      },
      initialRoute: HomeScreen.path,
      themeMode: ThemeMode.system,
      theme: ThemeHolder.light,
      darkTheme: ThemeHolder.dark,
      builder: (context, child) {
        assert(child != null);
        return Dependencies(child: child!);
      },
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CredentialsDao>(
          create: (context) =>
              const SecureCredentialsDao(storage: FlutterSecureStorage()),
        ),
        RepositoryProvider<Api>(
          create: (context) => DioApi(),
        ),
      ],
      child: RepositoryProvider<Repository>(
        create: (context) => RepositoryImpl(
          api: context.read(),
          credentialsDao: context.read(),
        ),
        child: BlocProvider(
          create: (context) => AccountsBloc(repository: context.read()),
          child: child,
        ),
      ),
    );
  }
}
