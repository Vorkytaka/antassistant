import 'package:antassistant/data/repository.dart';
import 'package:antassistant/entity/account_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class AccountsBloc extends Cubit<AccountsState> {
  final Repository repository;

  AccountsBloc({
    required this.repository,
  }) : super(const AccountsState(data: null)) {
    refresh();
  }

  dynamic refresh() async {
    emit(const AccountsState(data: null));
    final data = await repository.getData();
    emit(AccountsState(data: data));
  }
}

@immutable
class AccountsState {
  final List<AccountData>? data;

  const AccountsState({required this.data});
}
