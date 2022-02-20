// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Заполните поле`
  String get common__required_field {
    return Intl.message(
      'Заполните поле',
      name: 'common__required_field',
      desc: '',
      args: [],
    );
  }

  /// `Добавить аккаунт`
  String get common__add_account {
    return Intl.message(
      'Добавить аккаунт',
      name: 'common__add_account',
      desc: '',
      args: [],
    );
  }

  /// `Скопировать`
  String get common__copy {
    return Intl.message(
      'Скопировать',
      name: 'common__copy',
      desc: '',
      args: [],
    );
  }

  /// `Аккаунты`
  String get home__accounts_item {
    return Intl.message(
      'Аккаунты',
      name: 'home__accounts_item',
      desc: '',
      args: [],
    );
  }

  /// `Настройки`
  String get home__settings_item {
    return Intl.message(
      'Настройки',
      name: 'home__settings_item',
      desc: '',
      args: [],
    );
  }

  /// `Дней осталось:`
  String get accounts__days_left {
    return Intl.message(
      'Дней осталось:',
      name: 'accounts__days_left',
      desc: '',
      args: [],
    );
  }

  /// `Имя пользователя`
  String get login_form__login_hint {
    return Intl.message(
      'Имя пользователя',
      name: 'login_form__login_hint',
      desc: '',
      args: [],
    );
  }

  /// `Пароль`
  String get login_form__password_hint {
    return Intl.message(
      'Пароль',
      name: 'login_form__password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Войти`
  String get login_form__login_button {
    return Intl.message(
      'Войти',
      name: 'login_form__login_button',
      desc: '',
      args: [],
    );
  }

  /// `Показать пароль`
  String get login_form__show_password {
    return Intl.message(
      'Показать пароль',
      name: 'login_form__show_password',
      desc: '',
      args: [],
    );
  }

  /// `Скрыть пароль`
  String get login_form__hide_password {
    return Intl.message(
      'Скрыть пароль',
      name: 'login_form__hide_password',
      desc: '',
      args: [],
    );
  }

  /// `Не удалось авторизоваться`
  String get login_screen__error {
    return Intl.message(
      'Не удалось авторизоваться',
      name: 'login_screen__error',
      desc: '',
      args: [],
    );
  }

  /// `Баланс`
  String get account_details__balance {
    return Intl.message(
      'Баланс',
      name: 'account_details__balance',
      desc: '',
      args: [],
    );
  }

  /// `Дней осталось`
  String get account_details__days_left {
    return Intl.message(
      'Дней осталось',
      name: 'account_details__days_left',
      desc: '',
      args: [],
    );
  }

  /// `Кредит доверия`
  String get account_details__credit {
    return Intl.message(
      'Кредит доверия',
      name: 'account_details__credit',
      desc: '',
      args: [],
    );
  }

  /// `Код плательщика`
  String get account_details__account_number {
    return Intl.message(
      'Код плательщика',
      name: 'account_details__account_number',
      desc: '',
      args: [],
    );
  }

  /// `Цена за месяц`
  String get account_details__price_per_month {
    return Intl.message(
      'Цена за месяц',
      name: 'account_details__price_per_month',
      desc: '',
      args: [],
    );
  }

  /// `Цена за день`
  String get account_details__price_per_day {
    return Intl.message(
      'Цена за день',
      name: 'account_details__price_per_day',
      desc: '',
      args: [],
    );
  }

  /// `Название тарифа`
  String get account_details__tariff_name {
    return Intl.message(
      'Название тарифа',
      name: 'account_details__tariff_name',
      desc: '',
      args: [],
    );
  }

  /// `Скорость загрузки`
  String get account_details__download_speed {
    return Intl.message(
      'Скорость загрузки',
      name: 'account_details__download_speed',
      desc: '',
      args: [],
    );
  }

  /// `Скорость отдачи`
  String get account_details__upload_speed {
    return Intl.message(
      'Скорость отдачи',
      name: 'account_details__upload_speed',
      desc: '',
      args: [],
    );
  }

  /// `Скачано за текущий месяц`
  String get account_details__downloaded {
    return Intl.message(
      'Скачано за текущий месяц',
      name: 'account_details__downloaded',
      desc: '',
      args: [],
    );
  }

  /// `Ваш DynDNS`
  String get account_details__dyndns {
    return Intl.message(
      'Ваш DynDNS',
      name: 'account_details__dyndns',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
