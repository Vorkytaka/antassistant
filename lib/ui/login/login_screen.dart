import 'package:antassistant/domain/credentials/credentials_bloc.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/ui/login/bloc/login_screen_bloc.dart';
import 'package:antassistant/ui/login/login_screen_provider.dart';
import 'package:antassistant/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String path = '/login';

  static Widget builder(BuildContext context) => const LoginScreenProvider();

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButton(),
              Expanded(
                child: _Form(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  bool _passwordIsVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginScreenBloc, LoginScreenState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        switch (state.status) {
          case LoginScreenStatus.failure:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Не удалось авторизоваться'),
                behavior: SnackBarBehavior.floating,
              ),
            );
            break;
          case LoginScreenStatus.success:
            context.read<CredentialsBloc>().add(
                    credentials: Credentials(
                  login: state.login!,
                  password: state.password!,
                ));
            Navigator.of(context).pop();
            break;
          default:
            break;
        }
      },
      buildWhen: (prev, curr) => prev.status != curr.status,
      builder: (context, state) => Form(
        child: Builder(
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  label: Text('Логин'),
                ),
                onSaved: (login) =>
                    context.read<LoginScreenBloc>().setLogin(login),
                validator: (login) {
                  if (login == null || login.isEmpty) {
                    return 'Заполните поле';
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_passwordIsVisible,
                onSaved: (password) =>
                    context.read<LoginScreenBloc>().setPassword(password),
                decoration: InputDecoration(
                  label: const Text('Пароль'),
                  suffixIcon: _Visibility(
                    onPressed: () {
                      _passwordIsVisible = !_passwordIsVisible;
                      setState(() {});
                    },
                    visible: _passwordIsVisible,
                  ),
                ),
                validator: (login) {
                  if (login == null || login.isEmpty) {
                    return 'Заполните поле';
                  }
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: state.isLoading
                      ? null
                      : () {
                          final formState = Form.of(context);
                          assert(formState != null);

                          if (formState!.validate()) {
                            formState.save();
                            context.read<LoginScreenBloc>().login();
                          }
                        },
                  child: state.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('АВТОРИЗОВАТЬСЯ'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Visibility extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool visible;
  final Duration duration;

  const _Visibility({
    Key? key,
    this.onPressed,
    required this.visible,
    this.duration = const Duration(milliseconds: 150),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.visibility),
      ),
      secondChild: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.visibility_off),
      ),
      duration: duration,
      crossFadeState:
          visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
