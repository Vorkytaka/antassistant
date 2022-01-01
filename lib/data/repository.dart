import 'package:antassistant/entity/account_data.dart';
import 'package:antassistant/entity/credentials.dart';

abstract class Repository {
  Future<List<AccountData>> getData();

  Future<bool> login({required Credentials credentials});

  Future<void> saveCredentials({required Credentials credentials});

  Future<void> removeCredentials({required String login});
}

class MockRepository implements Repository {
  List<Credentials> _credentials = const [];

  @override
  Future<List<AccountData>> getData() async {
    return _credentials
        .map(
          (credentials) => AccountData(
            balance: 0,
            name: credentials.login,
            status: '',
            number: '',
            downloaded: 0,
            tariff: const Tariff(
              name: '',
              price: 720,
              downloadSpeed: '0',
              uploadSpeed: '0',
            ),
            credit: 0,
            dynDns: '',
            smsNotifications: false,
          ),
        )
        .toList(growable: false);
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
