import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@immutable
class Credentials {
  final String login;
  final String password;

  const Credentials({
    required this.login,
    required this.password,
  });

  @override
  String toString() {
    final pass = '•' * password.length;
    return 'Credentials($login, $pass)';
  }

  @override
  bool operator ==(Object other) =>
      other is Credentials &&
      login == other.login &&
      password == other.password;

  @override
  int get hashCode => hashValues(login, password);
}
