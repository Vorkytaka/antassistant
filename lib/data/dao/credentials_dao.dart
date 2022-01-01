import 'dart:collection';

import 'package:antassistant/entity/credentials.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

class SecureCredentialsDao implements CredentialsDao {
  final FlutterSecureStorage storage;

  const SecureCredentialsDao({required this.storage});

  @override
  Future<void> create({required Credentials credentials}) async {
    await storage.write(key: credentials.login, value: credentials.password);
  }

  @override
  Future<void> delete({required String login}) async {
    await storage.delete(key: login);
  }

  @override
  Future<Set<Credentials>> readAll() async {
    return storage.readAll().then((value) => {
          for (final login in value.keys)
            Credentials(login: login, password: value[login]!),
        });
  }
}
