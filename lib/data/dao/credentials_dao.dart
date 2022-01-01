import 'dart:collection';

import 'package:antassistant/entity/credentials.dart';

abstract class CredentialsDao {
  Future<void> create({required Credentials credentials});

  Future<Set<Credentials>> readAll();

  Future<void> delete({required String login});
}

class InMemoryCredentialsDao implements CredentialsDao {
  final Set<Credentials> _credentials = LinkedHashSet();

  @override
  Future<void> create({required Credentials credentials}) async {
    _credentials.add(credentials);
  }

  @override
  Future<Set<Credentials>> readAll() async {
    return _credentials.toSet();
  }

  @override
  Future<void> delete({required String login}) async {
    _credentials.removeWhere((credentials) => credentials.login == login);
  }
}
