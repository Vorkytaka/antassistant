import 'package:antassistant/data/repository.dart';
import 'package:antassistant/entity/account_data.dart';
import 'package:antassistant/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'main_screen_state.dart';

class MainScreenBloc extends Cubit<MainScreenState> with Logger {
  final Repository repository;

  MainScreenBloc({
    required this.repository,
  }) : super(MainScreenState.init()) {
    refresh();
  }

  dynamic refresh() async {
    emit(state.copyWith(loading: true));
    final data = await repository.getData();
    emit(state.copyWith(loading: false, data: data));
  }
}
