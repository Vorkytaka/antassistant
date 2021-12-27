import 'package:antassistant/ui/main/bloc/main_screen_bloc.dart';
import 'package:antassistant/ui/main/main_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  static const String path = '/';

  static Widget builder(BuildContext context) => const MainScreenProvider();

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MainScreenBloc, MainScreenState>(
        buildWhen: (prev, curr) => prev.status != curr.status,
        builder: (context, state) {
          switch (state.status) {
            case MainScreenStatus.loading:
              return Container();
            case MainScreenStatus.noAccounts:
              return Container();
            case MainScreenStatus.oneAccount:
              return Container();
            case MainScreenStatus.manyAccounts:
              return Container();
          }
        },
      ),
    );
  }
}
