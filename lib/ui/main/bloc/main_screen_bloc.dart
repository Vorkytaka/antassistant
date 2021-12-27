import 'package:antassistant/data/repository.dart';
import 'package:antassistant/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'main_screen_state.dart';

class MainScreenBloc extends Cubit<MainScreenState> with Logger {
  final Repository repository;

  MainScreenBloc({
    required this.repository,
  }) : super(const MainScreenState(status: MainScreenStatus.loading)) {
    repository.getCredentials().then((credentials) {
      final MainScreenStatus status;
      if (credentials.isEmpty) {
        status = MainScreenStatus.noAccounts;
      } else if (credentials.length == 1) {
        status = MainScreenStatus.oneAccount;
      } else {
        status = MainScreenStatus.manyAccounts;
      }
      emit(state.copyWith(status: status));
    });
  }
}
