// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accounts__days_left":
            MessageLookupByLibrary.simpleMessage("Дней осталось:"),
        "common__add_account":
            MessageLookupByLibrary.simpleMessage("Добавить аккаунт"),
        "common__required_field":
            MessageLookupByLibrary.simpleMessage("Заполните поле"),
        "home__accounts_item": MessageLookupByLibrary.simpleMessage("Аккаунты"),
        "home__settings_item":
            MessageLookupByLibrary.simpleMessage("Настройки"),
        "login_form__hide_password":
            MessageLookupByLibrary.simpleMessage("Скрыть пароль"),
        "login_form__login_button":
            MessageLookupByLibrary.simpleMessage("Войти"),
        "login_form__login_hint":
            MessageLookupByLibrary.simpleMessage("Имя пользователя"),
        "login_form__password_hint":
            MessageLookupByLibrary.simpleMessage("Пароль"),
        "login_form__show_password":
            MessageLookupByLibrary.simpleMessage("Показать пароль"),
        "login_screen__error":
            MessageLookupByLibrary.simpleMessage("Не удалось авторизоваться")
      };
}
