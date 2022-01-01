import 'package:antassistant/domain/credentials/credentials_bloc.dart';
import 'package:antassistant/ui/main/bloc/main_screen_bloc.dart';
import 'package:antassistant/ui/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenProvider extends StatelessWidget {
  const MainScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CredentialsBloc, CredentialsState>(
      builder: (context, state) {
        return BlocProvider(
          key: ValueKey(state),
          create: (context) => MainScreenBloc(
            repository: context.read(),
          ),
          lazy: false,
          child: const MainScreen(),
        );
      },
    );
  }
}
