import 'package:antassistant/domain/accounts/accounts_bloc.dart';
import 'package:antassistant/entity/account_data.dart';
import 'package:antassistant/ui/login/login_screen.dart';
import 'package:antassistant/ui/main/main_screen.dart';
import 'package:antassistant/utils/consts.dart';
import 'package:antassistant/utils/numbers.dart';
import 'package:antassistant/utils/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  static const String path = '/details';

  static Widget builder(
    BuildContext context,
    String accountName,
  ) =>
      DetailsScreen(accountName: accountName);

  const DetailsScreen({
    Key? key,
    required this.accountName,
  }) : super(key: key);

  final String accountName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SelectableText(
          accountName,
          enableInteractiveSelection: false,
          onTap: () => copyMessage(context: context, string: accountName),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          PopupMenuButton<int>(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            itemBuilder: (context) => [
              const PopupMenuVerticalPadding(),
              const PopupMenuItem(
                child: ListTile(
                  title: Text('Удалить'),
                  leading: Icon(Icons.delete_outlined),
                  contentPadding: EdgeInsets.zero,
                ),
                value: 1,
              ),
              const PopupMenuVerticalPadding(),
            ],
            onSelected: (id) {
              switch (id) {
                case 1:
                  delete(context: context, accountName: accountName);
                  break;
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocSelector<AccountsBloc, AccountsState, AccountData?>(
          selector: (state) => state.data?[accountName],
          builder: (context, data) {
            if (data == null) {
              return _NoData(accountName: accountName);
            }

            return _Content(data: data);
          },
        ),
      ),
    );
  }
}

class _NoData extends StatelessWidget {
  final String accountName;

  const _NoData({
    Key? key,
    required this.accountName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 24,
      ),
      child: Column(
        children: [
          Text(
            'Не удалось получить данные аккаунта',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Text(
                  'Обязательно проверьте подключение к интернету',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 12),
                Text(
                  'Возможно вы изменили пароль, но забыли обновить его в приложении?',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      LoginScreen.path,
                      arguments: accountName,
                    );
                  },
                  label: const Text('Обновить пароль'),
                  icon: const Icon(Icons.lock_outlined),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () {},
              label: const Text('ЗВОНОК В СЛУЖБУ ПОДДЕРЖКИ'),
              icon: const Icon(Icons.phone),
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final AccountData data;

  const _Content({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Material(
          color: Theme.of(context).colorScheme.background,
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Баланс',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 8),
                SelectableText(
                  '${data.balance.asString} ₽',
                  onTap: () => copyMessage(
                    context: context,
                    string: '${data.balance}',
                  ),
                  enableInteractiveSelection: false,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Дней осталось',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const SizedBox(height: 8),
                          SelectableText(
                            '${data.daysLeft}',
                            onTap: () => copyMessage(
                              context: context,
                              string: '${data.daysLeft}',
                            ),
                            enableInteractiveSelection: false,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Кредит доверия',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const SizedBox(height: 8),
                          SelectableText(
                            '${data.credit}',
                            onTap: () => copyMessage(
                              context: context,
                              string: '${data.credit}',
                            ),
                            enableInteractiveSelection: false,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              _ListItem(
                value: data.number,
                hint: 'Код плательщика',
              ),
              const Divider(height: 1),
              Row(
                children: [
                  Expanded(
                    child: _ListItem(
                      value: '${data.tariff.price.asString} ₽',
                      hint: 'Цена за месяц',
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: _ListItem(
                      value: '${data.tariff.pricePerDay.asString} ₽',
                      hint: 'Цена за день',
                    ),
                  )
                ],
              ),
              const Divider(height: 1),
              _ListItem(
                value: data.tariff.name,
                hint: 'Название тарифа',
                trailing: IconButton(
                  onPressed: () {
                    // todo:
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              const Divider(height: 1),
              Row(
                children: [
                  Expanded(
                    child: _ListItem(
                      value: data.tariff.downloadSpeed,
                      hint: 'Скорость загрузки',
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: _ListItem(
                      value: data.tariff.uploadSpeed,
                      hint: 'Скорость отдачи',
                    ),
                  )
                ],
              ),
              const Divider(height: 1),
              _ListItem(
                value: '${data.downloaded.asString} Мб',
                hint: 'Скачано за текущий месяц',
              ),
              const Divider(height: 1),
              _ListItem(
                value: data.dynDns,
                hint: 'Ваш DynDNS',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  final String value;
  final String hint;
  final Widget? trailing;

  const _ListItem({
    Key? key,
    required this.value,
    required this.hint,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(value),
      subtitle: Text(hint),
      onTap: () => copyMessage(context: context, string: value),
      trailing: trailing,
    );
  }
}

dynamic selectionHint({required BuildContext context}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Зажмите текст, чтобы выделить'),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

dynamic copyMessage({
  required BuildContext context,
  required String string,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(string),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Скопировать',
        onPressed: () {},
      ),
    ),
  );
}
