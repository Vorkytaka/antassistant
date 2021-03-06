import 'package:animations/animations.dart';
import 'package:antassistant/domain/accounts/accounts_bloc.dart';
import 'package:antassistant/entity/account_data.dart';
import 'package:antassistant/generated/l10n.dart';
import 'package:antassistant/launcher.dart';
import 'package:antassistant/preferences.dart';
import 'package:antassistant/ui/details/details_screen.dart';
import 'package:antassistant/ui/login/login_screen.dart';
import 'package:antassistant/utils/consts.dart';
import 'package:antassistant/utils/intl.dart';
import 'package:antassistant/utils/navigation.dart';
import 'package:antassistant/utils/numbers.dart';
import 'package:antassistant/utils/platform/platform.dart';
import 'package:antassistant/utils/popup_menu.dart';
import 'package:antassistant/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeScreenState {
  loading,
  noAccounts,
  oneAccount,
  hasAccounts,
}

enum HomeScreenDestination {
  accounts,
  settings,
}

class HomeScreen extends StatefulWidget {
  static const String path = '/';

  static Widget builder(BuildContext context) => const HomeScreen();

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenDestination _destination = HomeScreenDestination.accounts;

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final isCompact = data.windowSize == WindowSize.compact;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: isCompact ? _AppBar(destination: _destination) : null,
      body: Row(
        children: [
          if (!isCompact)
            NavigationRail(
              leading: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    FloatingActionButton.extended(
                      onPressed: () {
                        login(context: context);
                      },
                      icon: const Icon(Icons.add),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      tooltip: data.windowSize == WindowSize.expanded
                          ? null
                          : S.of(context).common__add_account,
                      label: Text(S.of(context).common__add_account),
                      isExtended: data.windowSize == WindowSize.expanded,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              labelType: data.windowSize == WindowSize.expanded
                  ? null
                  : NavigationRailLabelType.all,
              extended: data.windowSize == WindowSize.expanded,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(PlatformIcons.account),
                  selectedIcon: Icon(PlatformIcons.accountActive),
                  label: Text(S.of(context).home__accounts_item),
                ),
                NavigationRailDestination(
                  icon: Icon(PlatformIcons.settings),
                  selectedIcon: Icon(PlatformIcons.settingsActive),
                  label: Text(S.of(context).home__settings_item),
                ),
              ],
              selectedIndex: _destination.index,
              onDestinationSelected: (i) => setState(() {
                _destination = HomeScreenDestination.values[i];
              }),
            ),
          Expanded(child: _HomeBody(destination: _destination)),
        ],
      ),
      bottomNavigationBar: isCompact
          ? BlocSelector<AccountsBloc, AccountsState, bool>(
              selector: (state) => state.data != null && state.data!.isNotEmpty,
              builder: (context, state) {
                if (state) {
                  return PlatformBottomNavigationBar(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    currentIndex: _destination.index,
                    onTap: (i) => setState(() {
                      _destination = HomeScreenDestination.values[i];
                    }),
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(PlatformIcons.account),
                        activeIcon: Icon(PlatformIcons.accountActive),
                        label: S.of(context).home__accounts_item,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(PlatformIcons.settings),
                        activeIcon: Icon(PlatformIcons.settingsActive),
                        label: S.of(context).home__settings_item,
                      ),
                    ],
                  );
                }

                return const SizedBox();
              },
            )
          : null,
    );
  }
}

class _HomeBody extends StatelessWidget {
  final HomeScreenDestination destination;

  const _HomeBody({
    Key? key,
    required this.destination,
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
      child: destination == HomeScreenDestination.accounts
          ? _AccountBody()
          : _SettingsBody(),
    );
  }
}

// todo: handle last selected name on previous type
class _AccountBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return data.windowSize == WindowSize.compact
        ? _CompactAccountBody()
        : _LargeAccountBody();
  }
}

class _LargeAccountBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _HomeScreenStateWidget(
      builder: (context, state) {
        switch (state) {
          case HomeScreenState.loading:
            return _Loading();
          case HomeScreenState.noAccounts:
            return _NoAccounts();
          case HomeScreenState.oneAccount:
          case HomeScreenState.hasAccounts:
            return _AccountListDetailsBody();
        }
      },
    );
  }
}

class _AccountListDetailsBody extends StatefulWidget {
  @override
  State<_AccountListDetailsBody> createState() =>
      _AccountListDetailsBodyState();
}

class _AccountListDetailsBodyState extends State<_AccountListDetailsBody> {
  String? _selectedName;

  @override
  void deactivate() {
    if (MediaQuery.of(context).windowSize == WindowSize.compact) {
      // todo?
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Row(
      children: [
        Expanded(
          flex: data.windowSize == WindowSize.medium ? 2 : 1,
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            shape: const Border(),
            child: MediaQuery(
              data: data.removePadding(
                removeLeft: true,
                removeRight: true,
              ),
              child: _AccountList(
                selectedName: _selectedName,
                onTap: (BuildContext context, String accountName) {
                  setState(() {
                    if (_selectedName == accountName) {
                      _selectedName = null;
                    } else {
                      _selectedName = accountName;
                    }
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(
          flex: data.windowSize == WindowSize.medium ? 3 : 2,
          child: Material(
            elevation: 1,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: _selectedName != null
                  ? Column(
                      key: ValueKey(_selectedName),
                      children: [
                        Container(
                          height: MediaQuery.of(context).padding.top,
                          width: double.infinity,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        Expanded(
                          child: AccountBody(
                            accountName: _selectedName!,
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        '???????????????? ??????????????',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingsBody extends StatelessWidget {
  static const x = Object();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          ListTile(
            title: Text('???????? ????????????????????'),
            subtitle: Text(
                (ThemeMode.values[Preferences.getInt(context, 'themeMode', 0)!])
                    .intl(context)),
            trailing: Icon(Icons.adaptive.arrow_forward),
            onTap: () => setTheme(context: context),
          ),
          const Divider(
            indent: 70,
            height: 1,
          ),
          ListTile(
            title: Text('????????????????????'),
            subtitle: Text((TargetPlatform
                    .values[Preferences.getInt(context, 'platform', 0)!])
                .toString()),
            trailing: Icon(Icons.adaptive.arrow_forward),
            onTap: () => setPlatform(context: context),
          ),
          const Divider(
            thickness: 12,
            height: 12,
          ),
          const ListTile(
            title: Text('????????????'),
          ),
          if (Launcher.of(context).phone) ...[
            ListTile(
              leading: Icon(Icons.call),
              title: Text('???????????? ?? ???????????? ??????????????????'),
              onTap: () {},
            ),
            const Divider(
              indent: 70,
              height: 1,
            ),
          ],
          if (Launcher.of(context).web)
            ListTile(
              leading: Icon(Icons.language),
              title: Text('????????'),
              onTap: () => Launcher.site(context),
            ),
        ],
      ),
    );
  }

  static Future<void> setPlatform({
    required BuildContext context,
  }) async {
    final currentPlatform =
        TargetPlatform.values[Preferences.getInt(context, 'platform', 0)];
    final TargetPlatform? selectedPlatform = await showPlatformModalSheet(
      context: context,
      builder: (context) => PlatformModalDialog(
        actions: [
          for (final platform in TargetPlatform.values)
            PlatformModalAction(
              child: Text(platform.toString()),
              onPressed: () => Navigator.of(context).pop(platform),
            ),
        ],
      ),
    );

    if (selectedPlatform != null && selectedPlatform != currentPlatform) {
      Preferences.setInt(context, 'platform', selectedPlatform.index);
    }
  }

  static Future<void> setTheme({
    required BuildContext context,
  }) async {
    final currentMode =
        ThemeMode.values[Preferences.getInt(context, 'themeMode', 0)!];
    final ThemeMode? selectedMode = await showPlatformModalSheet(
      context: context,
      builder: (context) => PlatformModalDialog(
        actions: [
          for (final mode in ThemeMode.values)
            PlatformModalAction(
              child: Text(mode.intl(context)),
              onPressed: () => Navigator.of(context).pop(mode),
              trailing:
                  currentMode == mode ? const Icon(Icons.check_circle) : null,
              isDefaultAction: currentMode == mode,
            ),
        ],
      ),
    );

    if (selectedMode != null && selectedMode != currentMode) {
      Preferences.setInt(context, 'themeMode', selectedMode.index);
    }
  }
}

class _CompactAccountBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: _HomeScreenStateWidget(
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
              return _AccountList(
                onTap: (context, name) {
                  Navigator.of(context).push(
                    AutoPopRoute(
                      builder: (context) => DetailsScreen(accountName: name),
                      validator: (context) =>
                          MediaQuery.of(context).windowSize !=
                          WindowSize.compact,
                      onAutoPop: () {
                        // todo?
                      },
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}

typedef _HomeScreenStateBuilder = Widget Function(
  BuildContext context,
  HomeScreenState state,
);

class _HomeScreenStateWidget extends StatelessWidget {
  final _HomeScreenStateBuilder builder;

  const _HomeScreenStateWidget({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountsBloc, AccountsState, HomeScreenState>(
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
      builder: builder,
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: PlatformProgressIndicator(),
    );
  }
}

class _NoAccounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final EdgeInsets padding;
        switch (constraint.windowSize) {
          case WindowSize.compact:
            padding = const EdgeInsets.symmetric(horizontal: horizontalPadding);
            break;
          case WindowSize.medium:
            padding = EdgeInsets.symmetric(
              horizontal: constraint.maxWidth / 5,
              vertical: constraint.maxHeight / 3,
            );
            break;
          case WindowSize.expanded:
            padding = EdgeInsets.symmetric(
              horizontal: constraint.maxWidth / 4,
              vertical: constraint.maxHeight / 5,
            );
            break;
        }
        return Padding(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    '???????????????? ???????? ??????????????,\n?????????? ?????????????????????? ?????? ??????????????????',
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
                    child: PlatformButton.primary(
                      onPressed: () async {
                        login(context: context);
                      },
                      child: Text(S.of(context).common__add_account),
                    ),
                  ),
                  if (Launcher.of(context).phone) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 56,
                      child: PlatformButton.secondary(
                        onPressed: () => Launcher.phone(context),
                        child: const Text('???????????? ??????????????????'),
                      ),
                    ),
                  ],
                  const SizedBox(height: 56 + 16),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

typedef _OnAccountTap = void Function(BuildContext context, String accountName);

class _AccountList extends StatelessWidget {
  final _OnAccountTap onTap;
  final String? selectedName;

  const _AccountList({
    Key? key,
    required this.onTap,
    this.selectedName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AccountsBloc, AccountsState, Map<String, AccountData?>>(
      selector: (state) => state.data ?? const {},
      builder: (context, state) {
        final keys = state.keys.toList(growable: false);
        return ListView.separated(
          itemCount: state.length,
          separatorBuilder: (context, i) => const Divider(height: 1),
          itemBuilder: (context, i) => _Item(
            name: keys[i],
            data: state[keys[i]],
            onTap: onTap,
            isSelected: keys[i] == selectedName,
          ),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  final String name;
  final AccountData? data;
  final _OnAccountTap onTap;
  final bool isSelected;

  const _Item({
    Key? key,
    required this.name,
    this.data,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      onTap: () => onTap(context, name),
      onLongPress: () => itemMenu(
        context: context,
        accountName: name,
        data: data,
      ),
      selected: isSelected,
      selectedTileColor: Theme.of(context).selectedRowColor,
      trailing: data != null
          ? Text('${data!.balance.asString} ???')
          : Icon(
              Icons.warning,
              color: Theme.of(context).errorColor,
            ),
      subtitle: data != null
          ? Text('${S.of(context).accounts__days_left} ${data!.daysLeft}')
          : Text(
              '???? ?????????????? ???????????????? ????????????',
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final HomeScreenDestination destination;

  final List<WidgetBuilder> appBars = [
    (context) => AppBar(
          key: const ValueKey(0),
          title: BlocBuilder<AccountsBloc, AccountsState>(
            builder: (context, state) {
              if (state.data != null && state.data!.length == 1) {
                return Text(state.data!.keys.first);
              }

              return const Text('ANTAssistant');
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          actions: [
            _HomeScreenStateWidget(
              builder: (context, state) {
                if (state == HomeScreenState.loading ||
                    state == HomeScreenState.noAccounts) {
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
                      PopupMenuItem(
                        child: ListTile(
                          title: Text(S.of(context).common__add_account),
                          leading: const Icon(Icons.add),
                          contentPadding: EdgeInsets.zero,
                        ),
                        value: 1,
                      ),
                      if (state == HomeScreenState.oneAccount)
                        PopupMenuItem(
                          child: ListTile(
                            title: Text(S.of(context).common__delete),
                            leading: const Icon(Icons.delete),
                            contentPadding: EdgeInsets.zero,
                          ),
                          value: 2,
                        ),
                      const PopupMenuVerticalPadding(),
                    ],
                    onSelected: (id) {
                      switch (id) {
                        case 1:
                          login(context: context);
                          break;
                        case 2:
                          delete(
                            context: context,
                            accountName: context
                                .read<AccountsBloc>()
                                .state
                                .data!
                                .keys
                                .first,
                          );
                          break;
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
    (context) => AppBar(
          key: const ValueKey(1),
          title: const Text('??????????????????'),
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
  ];

  _AppBar({
    Key? key,
    required this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: appBars[destination.index](context),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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
  final bool result = await showPlatformDialog<bool>(
        context: context,
        builder: (context) => PlatformAlertDialog(
          title: Text(S.of(context).delete_account__title),
          content: Text(S.of(context).delete_account__content(accountName)),
          actions: [
            PlatformAlertDialogAction(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(S.of(context).common__no),
            ),
            PlatformAlertDialogAction(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                primary: Theme.of(context).errorColor,
              ),
              isDestructiveAction: true,
              child: Text(
                S.of(context).common__yes,
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
  final data = MediaQuery.of(context);

  void onPressed() async {
    Navigator.of(context).pop();
    // We use `Navigator.of(context).context`,
    // because context of dialog will be unmount after `pop`
    await delete(
      context: Navigator.of(context).context,
      accountName: accountName,
    );
  }

  ;

  if (data.windowSize == WindowSize.compact) {
    return showPlatformModalSheet(
      context: context,
      builder: (context) => PlatformModalDialog(
        title: Text(accountName),
        actions: [
          PlatformModalAction(
            child: Text(S.of(context).common__delete),
            leading: const Icon(Icons.delete),
            isDestructiveAction: true,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }

  return showPlatformDialog(
    context: context,
    builder: (context) => PlatformActionsDialog(
      title: Text(accountName),
      actions: [
        PlatformDialogAction(
          child: Text(S.of(context).common__delete),
          leading: const Icon(Icons.delete),
          isDestructiveAction: true,
          onPressed: onPressed,
        ),
      ],
    ),
  );
}

/// Show responsive menu
/// If device is compact, then we show modal bottom sheet
/// otherwise we show alertdialog
Future<void> showResponsiveMenu({
  required BuildContext context,
  required WidgetBuilder builder,
}) async {
  final data = MediaQuery.of(context);
  if (data.windowSize == WindowSize.compact) {
    return showModalBottomSheet(
      context: context,
      builder: builder,
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: builder(context),
      ),
    );
  }
}
