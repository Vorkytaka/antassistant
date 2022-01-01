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
  Future<List<AccountData>> getData() async {
    final credentials = await credentialsDao.readAll();
    for (final c in credentials) {
      api.getData(credentials: c);
    }
    return const [];
  }

  @override
  Future<bool> login({required Credentials credentials}) async =>
      api.login(credentials: credentials);

  @override
  Future<void> removeCredentials({required String login}) async {
    await credentialsDao.delete(login: login);
  }

  @override
  Future<void> saveCredentials({required Credentials credentials}) async {
    await credentialsDao.create(credentials: credentials);
  }
}
