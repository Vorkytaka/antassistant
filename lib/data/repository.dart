import 'package:antassistant/entity/credentials.dart';

abstract class Repository {
  Future<List<Credentials>> getCredentials();

  Future<bool> login({required Credentials credentials});

  Future<void> saveCredentials({required Credentials credentials});

  Future<void> removeCredentials({required String login});
}

class MockRepository implements Repository {
  List<Credentials> _credentials = const [];

  @override
  Future<List<Credentials>> getCredentials() async {
    return _credentials;
  }

  @override
  Future<bool> login({required Credentials credentials}) async {
    await Future.delayed(const Duration(seconds: 1));
    return credentials.login == 'qwerty' && credentials.password == 'qwerty';
  }

  @override
  Future<void> saveCredentials({required Credentials credentials}) async {
    if (_credentials.contains(credentials)) return;
    _credentials = [..._credentials, credentials];
  }

  @override
  Future<void> removeCredentials({required String login}) async {
    _credentials = [..._credentials]
      ..removeWhere((credentials) => credentials.login == login);
  }
}
