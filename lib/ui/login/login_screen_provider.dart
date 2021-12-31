import 'package:antassistant/ui/login/bloc/login_screen_bloc.dart';
import 'package:antassistant/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenProvider extends StatelessWidget {
  const LoginScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginScreenBloc(repository: context.read()),
      child: const LoginScreen(),
    );
  }
}
