import 'package:antassistant/data/dao/credentials_dao.dart';
import 'package:antassistant/data/repository.dart';
import 'package:antassistant/data/service/service.dart';
import 'package:antassistant/entity/account_data.dart';
import 'package:antassistant/entity/credentials.dart';

class RepositoryImpl implements Repository {
  final Api api;
  final CredentialsDao credentialsDao;

  const RepositoryImpl({
    required this.api,
    required this.credentialsDao,
  });

  @override
  Future<Map<String, AccountData?>> getData() async {
    final credentials = await credentialsDao.readAll();
    final docs =
        await Future.wait(credentials.map((c) => api.getData(credentials: c)));
    final data = docs.map((d) => d != null ? parseUserData(d) : null);
    return Map.fromIterable(
      data,
      key: (e) => e.name,
    );
    // return Future.wait(credentials.map((e) => api.getData(credentials: e)))
    //     .then((value) => value.map((e) => parseUserData(e!)).toList());
  }

  @override
  Future<bool> login({required Credentials credentials}) async =>
      api.login(credentials: credentials);

  @override
  Future<bool> removeCredentials({required String username}) async {
    return credentialsDao.delete(username: username);
  }

  @override
  Future<void> saveCredentials({required Credentials credentials}) async {
    await credentialsDao.create(credentials: credentials);
  }
}
