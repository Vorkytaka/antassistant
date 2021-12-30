import 'package:antassistant/ui/login/login_screen.dart';
import 'package:antassistant/ui/main/bloc/main_screen_bloc.dart';
import 'package:antassistant/ui/main/main_screen_provider.dart';
import 'package:antassistant/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  static const String path = '/';

  static Widget builder(BuildContext context) => const MainScreenProvider();

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MainScreenBloc, MainScreenState>(
          buildWhen: (prev, curr) => prev.status != curr.status,
          builder: (context, state) {
            switch (state.status) {
              case MainScreenStatus.loading:
                return _Loading();
              case MainScreenStatus.noAccounts:
                return _NoAccounts();
              case MainScreenStatus.oneAccount:
                return Container();
              case MainScreenStatus.manyAccounts:
                return Container();
            }
          },
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _NoAccounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Добавьте свой аккаунт,\nчтобы отслеживать его состояние',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(LoginScreen.path),
                  child: const Text('ДОБАВИТЬ АККАУНТ'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 56,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('СЛУЖБА ПОДДЕРЖКИ'),
                ),
              ),
              const SizedBox(height: 56 + 16),
            ],
          ),
        ],
      ),
    );
  }
}
