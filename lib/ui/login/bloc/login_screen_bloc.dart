import 'package:antassistant/data/repository.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class LoginScreenBloc extends Cubit<LoginScreenState> with Logger {
  final Repository repository;

  LoginScreenBloc({
    required this.repository,
  }) : super(LoginScreenState.init());

  void setUsername(String? login) => emit(state.copyWith(login: login));

  void setPassword(String? password) =>
      emit(state.copyWith(password: password));

  Future<void> login() async {
    assert(state.username != null);
    assert(state.password != null);

    emit(state.copyWith(status: LoginScreenStatus.loading));

    final credentials = Credentials(
      username: state.username!,
      password: state.password!,
    );

    final result = await repository.login(credentials: credentials);

    if (result) {
      await repository.saveCredentials(credentials: credentials);
    }

    emit(state.copyWith(
      status: result ? LoginScreenStatus.success : LoginScreenStatus.failure,
    ));
  }
}

@immutable
class LoginScreenState {
  final String? username;
  final String? password;
  final LoginScreenStatus status;

  const LoginScreenState({
    required this.username,
    required this.password,
    required this.status,
  });

  factory LoginScreenState.init() => const LoginScreenState(
        username: null,
        password: null,
        status: LoginScreenStatus.idle,
      );

  LoginScreenState copyWith({
    String? login,
    String? password,
    LoginScreenStatus? status,
  }) =>
      LoginScreenState(
        username: login ?? this.username,
        password: password ?? this.password,
        status: status ?? this.status,
      );

  @override
  String toString() {
    return 'LoginScreenState($username, $status)';
  }
}

enum LoginScreenStatus {
  idle,
  loading,
  success,
  failure,
}

extension LoginScreenStateUtils on LoginScreenState {
  bool get isLoading => status == LoginScreenStatus.loading;
}
