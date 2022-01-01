part of 'main_screen_bloc.dart';

@immutable
class MainScreenState {
  final bool loading;
  final List<AccountData> data;

  const MainScreenState({
    required this.loading,
    required this.data,
  });

  factory MainScreenState.init() => const MainScreenState(
        loading: true,
        data: [],
      );

  MainScreenState copyWith({
    bool? loading,
    List<AccountData>? data,
  }) =>
      MainScreenState(
        loading: loading ?? this.loading,
        data: data ?? this.data,
      );

  @override
  String toString() => 'MainScreenState($loading, $data)';
}
