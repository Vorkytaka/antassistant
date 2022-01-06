import 'package:antassistant/domain/accounts/accounts_bloc.dart';
import 'package:antassistant/entity/account_data.dart';
import 'package:antassistant/utils/consts.dart';
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
          onTap: () => copyMessage(context: context, string: accountName),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SafeArea(
        child: BlocSelector<AccountsBloc, AccountsState, AccountData?>(
          selector: (state) => state.data?[accountName],
          builder: (context, data) {
            if (data == null) {
              return _NoData();
            }

            return _Content(data: data);
          },
        ),
      ),
    );
  }
}

class _NoData extends StatelessWidget {
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
                TextButton(
                  onPressed: () {},
                  child: const Text('Обновить пароль'),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          ElevatedButton.icon(
            onPressed: () {},
            label: const Text('Звонок в службу поддержки'),
            icon: Icon(Icons.phone),
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
                  '${data.balance} ₽',
                  onTap: () => copyMessage(
                    context: context,
                    string: '${data.balance}',
                  ),
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
              ListTile(
                title: SelectableText(data.number),
                subtitle: const Text('Код плательщика'),
                onTap: () => copyMessage(context: context, string: data.number),
              ),
            ],
          ),
        ),
      ],
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
