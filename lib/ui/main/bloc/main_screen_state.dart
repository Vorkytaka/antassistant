part of 'main_screen_bloc.dart';

@immutable
class MainScreenState {
  final MainScreenStatus status;

  const MainScreenState({
    required this.status,
  });
}

enum MainScreenStatus {
  loading,
  noAccounts,
  oneAccount,
  manyAccounts,
}
