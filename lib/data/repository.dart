import 'package:antassistant/entity/credentials.dart';

abstract class Repository {
  Future<List<Credentials>> getCredentials();

  Future<bool> login({required Credentials credentials});
}

class MockRepository implements Repository {
  @override
  Future<List<Credentials>> getCredentials() async {
    return [];
  }

  @override
  Future<bool> login({required Credentials credentials}) async {
    await Future.delayed(const Duration(seconds: 1));
    return credentials.login == 'qwerty' && credentials.password == 'qwerty';
  }
}
