import 'package:animations/animations.dart';
import 'package:antassistant/domain/accounts/accounts_bloc.dart';
import 'package:antassistant/entity/account_data.dart';
import 'package:antassistant/ui/details/details_screen.dart';
import 'package:antassistant/ui/login/login_screen.dart';
import 'package:antassistant/utils/consts.dart';
import 'package:antassistant/utils/numbers.dart';
import 'package:antassistant/utils/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeScreenState {
  loading,
  noAccounts,
  oneAccount,
  hasAccounts,
}

class HomeScreen extends StatefulWidget {
  static const String path = '/';

  static Widget builder(BuildContext context) => const HomeScreen();

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// todo: move logic to the bloc
class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _Body(currentIndex: _currentIndex),
      ),
      bottomNavigationBar: BlocSelector<AccountsBloc, AccountsState, bool>(
        selector: (state) => state.data != null && state.data!.isNotEmpty,
        builder: (context, state) {
          if (state) {
            return BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() {
                _currentIndex = index;
              }),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  activeIcon: Icon(Icons.account_circle),
                  label: 'Аккаунты',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings),
                  label: 'Настройки',
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final int currentIndex;

  const _Body({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      transitionBuilder: (child, animation, secondaryAnimation) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: currentIndex == 0 ? _AccountBody() : _SettingsBody(),
    );
  }
}

class _SettingsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
    );
  }
}

class _AccountBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ANTAssistant'),
        actions: [
          BlocSelector<AccountsBloc, AccountsState, bool>(
            selector: (state) => state.data != null && state.data!.isNotEmpty,
            builder: (context, state) {
              if (!state) {
                return const SizedBox.shrink();
              } else {
                return PopupMenuButton<int>(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuVerticalPadding(),
                    const PopupMenuItem(
                      child: ListTile(
                        title: Text('Добавить'),
                        leading: Icon(Icons.add),
                        contentPadding: EdgeInsets.zero,
                      ),
                      value: 1,
                    ),
                    const PopupMenuVerticalPadding(),
                  ],
                  onSelected: (id) {
                    switch (id) {
                      case 1:
                        login(context: context);
                        break;
                    }
                  },
                );
              }
            },
          ),
        ],
      ),
      body: BlocSelector<AccountsBloc, AccountsState, HomeScreenState>(
        selector: (state) {
          if (state.data == null) {
            return HomeScreenState.loading;
          } else if (state.data!.isEmpty) {
            return HomeScreenState.noAccounts;
          } else if (state.data!.length == 1) {
            return HomeScreenState.oneAccount;
          } else {
            return HomeScreenState.hasAccounts;
          }
        },
        builder: (context, state) {
          switch (state) {
            case HomeScreenState.loading:
              return _Loading();
            case HomeScreenState.noAccounts:
              return _NoAccounts();
            case HomeScreenState.oneAccount:
              return BlocSelector<AccountsBloc, AccountsState, String>(
                selector: (state) => state.data?.keys.first ?? '',
                builder: (context, state) => AccountBody(accountName: state),
              );
            case HomeScreenState.hasAccounts:
              return _AccountList();
          }
        },
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
        BlocSelector<AccountsBloc, AccountsState, Map<String, AccountData?>>(
          selector: (state) => state.data ?? const {},
          builder: (context, state) {
            final keys = state.keys.toList(growable: false);
            return ListView.separated(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: state.length,
              separatorBuilder: (context, i) => const Divider(height: 1),
              itemBuilder: (context, i) => _Item(
                name: keys[i],
                data: state[keys[i]],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final String name;
  final AccountData? data;

  const _Item({
    Key? key,
    required this.name,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      onTap: () {
        Navigator.of(context).pushNamed(DetailsScreen.path, arguments: name);
      },
      onLongPress: () => itemMenu(
        context: context,
        accountName: name,
        data: data,
      ),
      trailing: data != null
          ? Text('${data!.balance.asString} ₽')
          : Icon(
              Icons.warning,
              color: Theme.of(context).errorColor,
            ),
      subtitle: data != null
          ? Text('Осталось дней: ${data!.daysLeft}')
          : Text(
              'Не удалось получить данные',
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
    );
  }
}

Future<void> login({required BuildContext context}) async {
  final bool result =
      (await Navigator.of(context).pushNamed<dynamic>(LoginScreen.path)) ??
          false;

  if (result) {
    context.read<AccountsBloc>().refresh();
  }
}

Future<bool> delete({
  required BuildContext context,
  required String accountName,
}) async {
  final bool result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Удалить аккаунт'),
          content: Text('Вы уверены, что хотите удалить аккаунт $accountName?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Нет'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                primary: Theme.of(context).errorColor,
              ),
              child: Text(
                'Да',
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
            ),
          ],
        ),
      ) ??
      false;

  if (result) {
    return context.read<AccountsBloc>().removeAccount(username: accountName);
  }

  return false;
}

Future<void> itemMenu({
  required BuildContext context,
  required String accountName,
  required AccountData? data,
}) async {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: MediaQuery.of(context).padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text(
              accountName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          ListTile(
            title: const Text('Удалить'),
            leading: const Icon(Icons.delete),
            onTap: () {
              Navigator.of(context).pop();
              delete(context: context, accountName: accountName);
            },
          ),
        ],
      ),
    ),
  );
}
