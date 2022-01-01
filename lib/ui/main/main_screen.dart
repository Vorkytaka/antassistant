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
          builder: (context, state) {
            if (state.loading) {
              return _Loading();
            } else if (state.data.isEmpty) {
              return _NoAccounts();
            } else {
              return _AccountList();
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
                  onPressed: () async {
                    final bool result = (await Navigator.of(context)
                            .pushNamed<dynamic>(LoginScreen.path)) ??
                        false;

                    if (result) {
                      context.read<MainScreenBloc>().refresh();
                    }
                  },
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

class _AccountList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 24),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
          child: Text(
            'Аккаунты',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        const SizedBox(height: 16),
        BlocBuilder<MainScreenBloc, MainScreenState>(
          buildWhen: (prev, curr) => prev.data != curr.data,
          builder: (context, state) => ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: state.data.length,
            separatorBuilder: (context, i) => const Divider(height: 1),
            itemBuilder: (context, i) => ListTile(
              title: Text(state.data[i].name),
              onTap: () {},
              trailing: Text(state.data[i].balance.toString()),
              subtitle: Text('Осталось дней: ${state.data[i].daysLeft}'),
            ),
          ),
        ),
      ],
    );
  }
}
