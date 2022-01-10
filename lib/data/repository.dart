import 'package:antassistant/entity/account_data.dart';
import 'package:antassistant/entity/credentials.dart';

abstract class Repository {
  Future<Map<String, AccountData?>> getData();

  Future<bool> login({required Credentials credentials});

  Future<void> saveCredentials({required Credentials credentials});

  Future<bool> removeCredentials({required String username});
}
