import 'package:antassistant/entity/account_data.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

const String _baseUrl = 'http://cabinet.a-n-t.ru/cabinet.php';
const String _keyAction = 'action';
const String _keyUsername = 'user_name';
const String _keyPassword = 'user_pass';
const String _actionInfo = 'info';
const String _actionChangeTarif = 'changetar';

abstract class Api {
  Future<bool> login({required Credentials credentials});

  Future<Document?> getData({required Credentials credentials});

  Future<Document?> changeTariffPage({required Credentials credentials});
}

class DioApi implements Api {
  @override
  Future<bool> login({required Credentials credentials}) async {
    final BaseOptions options = BaseOptions(followRedirects: true);
    final params = {
      _keyAction: _actionInfo,
      _keyUsername: credentials.username,
      _keyPassword: credentials.password
    };
    final httpParams = FormData.fromMap(params);

    try {
      await Dio(options).post(_baseUrl, data: httpParams);
      return true;
    } catch (err) {
      return false;
    }
  }

  @override
  Future<Document?> getData({required Credentials credentials}) async {
    final BaseOptions options = BaseOptions(followRedirects: true);
    var params = {
      _keyAction: _actionInfo,
      _keyUsername: credentials.username,
      _keyPassword: credentials.password
    };
    var httpParams = FormData.fromMap(params);

    try {
      return Dio(options)
          .post<String>(_baseUrl, data: httpParams)
          .then((res) => parse(res.data));
    } catch (err) {
      return null;
    }
  }

  @override
  Future<Document?> changeTariffPage({required Credentials credentials}) async {
    final BaseOptions options = BaseOptions(followRedirects: true);
    var params = {
      _keyAction: _actionChangeTarif,
      _keyUsername: credentials.username,
      _keyPassword: credentials.password
    };
    var httpParams = FormData.fromMap(params);

    try {
      return Dio(options)
          .post<String>(_baseUrl, data: httpParams)
          .then((res) => parse(res.data));
    } catch (err) {
      return null;
    }
  }
}

List<Tariff>? parseTariffList(Document? document) {
  if (document == null) {
    return null;
  }

  final selects = document.querySelectorAll('select');
  final select =
      selects.firstWhere((e) => e.attributes['name'] == 'new_tar_id');

  return select.children
      .map((e) => parseTariff(e.text)!)
      .toList(growable: false);
}

AccountData parseUserData(Document document) {
  final double? balance = double.tryParse(
    document.querySelector('td.num')!.text.replaceAll(' руб.', ''),
  );

  final tables = document.querySelectorAll('td.tables');
  String? accountName;
  String? number;
  String? dynDns;
  Tariff? tariff;
  int? credit;
  String? status;
  double? downloaded;
  String? smsInfo;
  for (var i = 0; i < tables.length; i += 3) {
    final ch = tables[i].nodes.first.text;
    switch (ch) {
      case 'Код плательщика':
        number = tables[i + 1].text;
        break;
      case 'Ваш DynDNS':
        dynDns = tables[i + 1].text;
        break;
      case 'Тариф':
        tariff = parseTariff(tables[i + 1].text);
        break;
      case 'Кредит доверия, руб':
        credit = int.parse(tables[i + 1].text);
        break;
      case 'Статус учетной записи':
        status = tables[i + 1].text;
        break;
      case 'Скачано за текущий месяц':
        downloaded =
            double.tryParse(tables[i + 1].text.replaceAll(' ( Мб. )', ''));
        break;
      case 'SMS-информирование':
        smsInfo = tables[i + 1].text;
        break;
      case 'Учетная запись':
        accountName = tables[i + 1].text.toLowerCase();
        break;
    }
  }

  return AccountData(
    balance: balance!,
    name: accountName!,
    status: status!,
    number: number!,
    downloaded: downloaded!,
    tariff: tariff!,
    credit: credit!,
    dynDns: dynDns!,
    smsInfo: smsInfo!, // todo
  );
}

Tariff? parseTariff(String? str) {
  if (str == null) {
    return null;
  }

  // название
  final tariffName = str.substring(0, str.indexOf(':'));

  // цена
  final priceStr = str.substring(str.indexOf(':') + 1, str.indexOf('р')).trim();
  final tariffPricePerMonth = double.parse(priceStr);

  // скорость
  // бывает двух типов
  // 100/100 Мб
  // или
  // до 100 Мб

  final speedRE = RegExp('\\d+/\\d+');
  final speedResult = speedRE.firstMatch(str);

  final String downloadSpeed;
  final String uploadSpeed;
  if (speedResult != null) {
    final speeds = speedResult.group(0)!.split('/');
    downloadSpeed = speeds[0];
    uploadSpeed = speeds[1];
  } else {
    final speed = str.substring(str.indexOf('до ') + 3, str.indexOf('('));
    downloadSpeed = speed;
    uploadSpeed = speed;
  }

  return Tariff(
    name: tariffName,
    price: tariffPricePerMonth,
    downloadSpeed: downloadSpeed,
    uploadSpeed: uploadSpeed,
  );
}
