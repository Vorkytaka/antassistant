import 'package:antassistant/entity/account_data.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:dio/dio.dart';

const String _baseUrl = 'http://cabinet.a-n-t.ru/cabinet.php';
const String _keyAction = 'action';
const String _keyUsername = 'user_name';
const String _keyPassword = 'user_pass';
const String _actionInfo = 'info';

abstract class Api {
  Future<bool> login({required Credentials credentials});

  Future<AccountData?> getData({required Credentials credentials});
}

class DioApi implements Api {
  @override
  Future<bool> login({required Credentials credentials}) async {
    final BaseOptions options = BaseOptions(followRedirects: true);
    final params = {
      _keyAction: _actionInfo,
      _keyUsername: credentials.login,
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
  Future<AccountData?> getData({required Credentials credentials}) async {
    final BaseOptions options = BaseOptions(followRedirects: true);
    var params = {
      _keyAction: _actionInfo,
      _keyUsername: credentials.login,
      _keyPassword: credentials.password
    };
    var httpParams = FormData.fromMap(params);

    try {
      final response = await Dio(options).post(_baseUrl, data: httpParams);

      return null;
    } catch (err) {
      return null;
    }
  }
}

/*
UserData parseUserData(ParsingData data) {
  int id = data.id;
  Document document = data.document;

  final balance = double.parse(
      document.querySelector("td.num").text.replaceAll(" руб.", ""));

  final tables = document.querySelectorAll("td.tables");
  String accountName;
  String userId;
  String dynDns;
  String tariffName;
  double tariffPricePerMonth;
  String downloadSpeed;
  String uploadSpeed;
  int credit;
  String status;
  int downloaded;
  String smsInfo;
  for (var i = 0; i < tables.length; i += 3) {
    final ch = tables[i].nodes.first.text;
    switch (ch) {
      case "Код плательщика":
        userId = tables[i + 1].text;
        break;
      case "Ваш DynDNS":
        dynDns = tables[i + 1].text;
        break;
      case "Тариф":
        final tariffStr = tables[i + 1].text;

        // название
        tariffName = tariffStr.substring(0, tariffStr.indexOf(":"));

        // цена
        final priceStr = tariffStr
            .substring(tariffStr.indexOf(":") + 1, tariffStr.indexOf("р"))
            .trim();
        tariffPricePerMonth = double.parse(priceStr);

        // скорость
        // бывает двух типов
        // 100/100 Мб
        // или
        // до 100 Мб

        final speedRE = RegExp("\\d+/\\d+");
        final speedResult = speedRE.firstMatch(tariffStr);
        if (speedResult != null) {
          final speeds = speedResult.group(0).split("/");
          downloadSpeed = speeds[0];
          uploadSpeed = speeds[1];
        } else {
          final speed = tariffStr.substring(
              tariffStr.indexOf("до ") + 3, tariffStr.indexOf("("));
          downloadSpeed = speed;
          uploadSpeed = speed;
        }

        break;

      case "Кредит доверия, руб":
        credit = int.parse(tables[i + 1].text);
        break;

      case "Статус учетной записи":
        status = tables[i + 1].text;
        break;

      case "Скачано за текущий месяц":
        downloaded = int.parse(tables[i + 1].text.replaceAll(" ( Мб. )", ""));
        break;

      case "SMS-информирование":
        smsInfo = tables[i + 1].text;
        break;

      case "Учетная запись":
        accountName = tables[i + 1].text;
        break;
    }
  }

  return UserData(
    credentialsId: id,
    accountName: accountName,
    accountId: userId,
    dynDns: dynDns,
    tariffInfo: TariffInfo(
      tariffName: tariffName,
      downloadSpeed: downloadSpeed,
      uploadSpeed: uploadSpeed,
      pricePerMonth: tariffPricePerMonth,
    ),
    statusInfo: StatusInfo(
      balance: balance,
      downloaded: downloaded,
      status: status,
      credit: credit,
      smsInfo: smsInfo,
    ),
  );
}
*/