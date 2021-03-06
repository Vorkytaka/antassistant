import 'package:antassistant/data/dao/credentials_dao.dart';
import 'package:antassistant/data/repository.dart';
import 'package:antassistant/data/repository_impl.dart';
import 'package:antassistant/data/service/service.dart';
import 'package:antassistant/domain/accounts/accounts_bloc.dart';
import 'package:antassistant/generated/l10n.dart';
import 'package:antassistant/launcher.dart';
import 'package:antassistant/preferences.dart';
import 'package:antassistant/theme.dart';
import 'package:antassistant/ui/details/details_screen.dart';
import 'package:antassistant/ui/login/login_screen.dart';
import 'package:antassistant/ui/main/main_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  final LauncherData launcherData;
  final SharedPreferences sharedPreferences;

  const App({
    Key? key,
    required this.launcherData,
    required this.sharedPreferences,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Preferences(
      sharedPreferences: sharedPreferences,
      builder: (context) {
        final platformIndex = Preferences.maybeInt(context, 'platform');
        final platform = platformIndex == null
            ? defaultTargetPlatform
            : TargetPlatform.values[platformIndex];
        return MaterialApp(
          title: 'ANTAssistant',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
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
          themeMode:
              ThemeMode.values[Preferences.getInt(context, 'themeMode', 0)!],
          theme: ThemeHolder.light(platform: platform),
          darkTheme: ThemeHolder.dark(platform: platform),
          builder: (context, child) {
            assert(child != null);
            return Dependencies(
              child: child!,
              launcherData: launcherData,
            );
          },
        );
      },
    );
  }
}

class Dependencies extends StatelessWidget {
  final Widget child;
  final LauncherData launcherData;

  const Dependencies({
    Key? key,
    required this.child,
    required this.launcherData,
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
          child: Launcher(
            data: launcherData,
            child: child,
          ),
        ),
      ),
    );
  }
}
