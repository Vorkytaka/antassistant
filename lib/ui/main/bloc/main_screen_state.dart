part of 'main_screen_bloc.dart';

@immutable
class MainScreenState {
  final MainScreenStatus status;

  const MainScreenState({
    required this.status,
  });

  MainScreenState copyWith({
    MainScreenStatus? status,
  }) =>
      MainScreenState(
        status: status ?? this.status,
      );

  @override
  String toString() => 'MainScreenState($status)';
}

enum MainScreenStatus {
  loading,
  noAccounts,
  oneAccount,
  manyAccounts,
}
