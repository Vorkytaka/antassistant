import 'package:antassistant/domain/accounts/accounts_bloc.dart';
import 'package:antassistant/entity/account_data.dart';
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
        title: Text(accountName),
      ),
      body: BlocSelector<AccountsBloc, AccountsState, AccountData?>(
        selector: (state) => state.data?[accountName],
        builder: (context, data) => Container(),
      ),
    );
  }
}
