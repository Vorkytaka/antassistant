import 'package:antassistant/entity/credentials.dart';

abstract class Repository {
  Future<List<Credentials>> getCredentials();
}

class MockRepository implements Repository {
  @override
  Future<List<Credentials>> getCredentials() async {
    return [];
  }
}
