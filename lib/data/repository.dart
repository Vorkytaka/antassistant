import 'package:antassistant/entity/credentials.dart';

abstract class Repository {
  Future<List<Credentials>> getCredentials();

  Future<bool> login({required Credentials credentials});

  Future<void> saveCredentials({required Credentials credentials});

  Future<void> removeCredentials({required String login});
}

class MockRepository implements Repository {
  final Set<Credentials> _credentials = {};

  @override
  Future<List<Credentials>> getCredentials() async {
    return [];
  }

  @override
  Future<bool> login({required Credentials credentials}) async {
    await Future.delayed(const Duration(seconds: 1));
    return credentials.login == 'qwerty' && credentials.password == 'qwerty';
  }

  @override
  Future<void> saveCredentials({required Credentials credentials}) async =>
      _credentials.add(credentials);

  @override
  Future<void> removeCredentials({required String login}) async {
    _credentials.removeWhere((credentials) => credentials.login == login);
  }
}
