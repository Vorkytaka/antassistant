import 'package:meta/meta.dart';

@immutable
class AccountData {
  final double balance;
  final String name;
  final String status;
  final String number;
  final double downloaded;
  final Tariff tariff;
  final int credit;
  final String dynDns;
  final bool smsNotifications;

  const AccountData({
    required this.balance,
    required this.name,
    required this.status,
    required this.number,
    required this.downloaded,
    required this.tariff,
    required this.credit,
    required this.dynDns,
    required this.smsNotifications,
  });
}

@immutable
class Tariff {
  final String name;
  final double price;
  final String downloadSpeed;
  final String uploadSpeed;

  const Tariff({
    required this.name,
    required this.price,
    required this.downloadSpeed,
    required this.uploadSpeed,
  });
}
