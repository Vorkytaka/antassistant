import 'package:antassistant/entity/account_data.dart';
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
                    login(context: context);
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
          padding: const EdgeInsets.only(left: horizontalPadding),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Аккаунты',
                style: Theme.of(context).textTheme.headline5,
              ),
              PopupMenuButton<int>(
                icon: const Icon(Icons.more_vert),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: Text('Добавить'),
                    value: 1,
                  ),
                ],
                onSelected: (id) {
                  switch (id) {
                    case 1:
                      login(context: context);
                      break;
                  }
                },
              ),
            ],
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
            itemBuilder: (context, i) => _Item(data: state.data[i]),
          ),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final AccountData data;

  const _Item({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.name),
      onTap: () {},
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  title: Text(
                    data.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  title: const Text('Удалить'),
                  leading: const Icon(Icons.delete),
                  onTap: () {},
                ),
              ],
            ),
          ),
        );
      },
      trailing: Text(data.balance.toString()),
      subtitle: Text('Осталось дней: ${data.daysLeft}'),
    );
  }
}

Future<void> login({required BuildContext context}) async {
  final bool result =
      (await Navigator.of(context).pushNamed<dynamic>(LoginScreen.path)) ??
          false;

  if (result) {
    context.read<MainScreenBloc>().refresh();
  }
}
