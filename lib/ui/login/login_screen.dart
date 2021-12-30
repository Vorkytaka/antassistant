import 'package:antassistant/utils/consts.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String path = '/login';

  static Widget builder(BuildContext context) => const LoginScreen();

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
    return Form(
      child: Column(
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
          ),
          const SizedBox(height: 16),
          TextFormField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
            obscureText: !_passwordIsVisible,
            decoration: InputDecoration(
              label: Text('Пароль'),
              suffixIcon: _Visibility(
                onPressed: () {
                  _passwordIsVisible = !_passwordIsVisible;
                  setState(() {});
                },
                visible: _passwordIsVisible,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('АВТОРИЗОВАТЬСЯ'),
            ),
          ),
        ],
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
