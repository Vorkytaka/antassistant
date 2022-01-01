import 'package:antassistant/data/repository.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class CredentialsBloc extends Cubit<CredentialsState> with Logger {
  final Repository repository;

  CredentialsBloc({
    required this.repository,
  }) : super(CredentialsState.init()) {
    refresh();
  }

  dynamic refresh() => repository
      .getCredentials()
      .then((credentials) => emit(CredentialsState(credentials: credentials)));

  dynamic add({required Credentials credentials}) async {
    await repository.saveCredentials(credentials: credentials);
    refresh();
  }
}

@immutable
class CredentialsState {
  final List<Credentials> credentials;

  const CredentialsState({
    required this.credentials,
  });

  factory CredentialsState.init() => const CredentialsState(credentials: []);

  @override
  String toString() =>
      'CredentialsState(${credentials.length}, ${credentials.join(', ')})';

  @override
  bool operator ==(Object other) =>
      other is CredentialsState && credentials == other.credentials;

  @override
  int get hashCode => credentials.hashCode;
}
