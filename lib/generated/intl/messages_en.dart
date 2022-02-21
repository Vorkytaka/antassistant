// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(accountName) =>
      "Are you sure you want to delete account ${accountName}?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "account_details__account_number":
            MessageLookupByLibrary.simpleMessage("Account number"),
        "account_details__balance":
            MessageLookupByLibrary.simpleMessage("Balance"),
        "account_details__credit":
            MessageLookupByLibrary.simpleMessage("Credit of trust"),
        "account_details__days_left":
            MessageLookupByLibrary.simpleMessage("Days left"),
        "account_details__download_speed":
            MessageLookupByLibrary.simpleMessage("Download speed"),
        "account_details__downloaded": MessageLookupByLibrary.simpleMessage(
            "Downloads for the current month"),
        "account_details__dyndns":
            MessageLookupByLibrary.simpleMessage("Your DynDNS"),
        "account_details__price_per_day":
            MessageLookupByLibrary.simpleMessage("Price per day"),
        "account_details__price_per_month":
            MessageLookupByLibrary.simpleMessage("Price per month"),
        "account_details__tariff_name":
            MessageLookupByLibrary.simpleMessage("Tariff name"),
        "account_details__upload_speed":
            MessageLookupByLibrary.simpleMessage("Upload speed"),
        "accounts__days_left":
            MessageLookupByLibrary.simpleMessage("Days left:"),
        "common__add_account":
            MessageLookupByLibrary.simpleMessage("Add account"),
        "common__copy": MessageLookupByLibrary.simpleMessage("Copy"),
        "common__delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "common__no": MessageLookupByLibrary.simpleMessage("No"),
        "common__required_field":
            MessageLookupByLibrary.simpleMessage("Required field"),
        "common__theme_dark": MessageLookupByLibrary.simpleMessage("Dark"),
        "common__theme_light": MessageLookupByLibrary.simpleMessage("Light"),
        "common__theme_system": MessageLookupByLibrary.simpleMessage("System"),
        "common__yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "delete_account__content": m0,
        "delete_account__title":
            MessageLookupByLibrary.simpleMessage("Delete account?"),
        "home__accounts_item": MessageLookupByLibrary.simpleMessage("Accounts"),
        "home__settings_item": MessageLookupByLibrary.simpleMessage("Settings"),
        "login_form__hide_password":
            MessageLookupByLibrary.simpleMessage("Hide password"),
        "login_form__login_button":
            MessageLookupByLibrary.simpleMessage("Login"),
        "login_form__login_hint":
            MessageLookupByLibrary.simpleMessage("Username"),
        "login_form__password_hint":
            MessageLookupByLibrary.simpleMessage("Password"),
        "login_form__show_password":
            MessageLookupByLibrary.simpleMessage("Show password"),
        "login_screen__error":
            MessageLookupByLibrary.simpleMessage("Authorization failed")
      };
}
