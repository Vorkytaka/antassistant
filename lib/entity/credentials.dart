import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@immutable
class Credentials {
  final String username;
  final String password;

  const Credentials({
    required this.username,
    required this.password,
  });

  @override
  String toString() {
    final pass = '•' * password.length;
    return 'Credentials($username, $pass)';
  }

  @override
  bool operator ==(Object other) =>
      other is Credentials &&
      username == other.username &&
      password == other.password;

  @override
  int get hashCode => hashValues(username, password);
}
