import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'main_screen_state.dart';

class MainScreenBloc extends Cubit<MainScreenState> {
  MainScreenBloc()
      : super(const MainScreenState(status: MainScreenStatus.loading));
}
