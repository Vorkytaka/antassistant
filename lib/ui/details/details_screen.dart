import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  static const String path = '/details';

  static Widget builder(
    BuildContext context,
    String accountName,
  ) =>
      DetailsScreen(accountName: accountName);

  const DetailsScreen({
    Key? key,
    required this.accountName,
  }) : super(key: key);

  final String accountName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(accountName),
      ),
    );
  }
}
