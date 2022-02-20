import 'package:antassistant/generated/l10n.dart';
import 'package:antassistant/ui/login/bloc/login_screen_bloc.dart';
import 'package:antassistant/ui/login/login_screen_provider.dart';
import 'package:antassistant/utils/padding.dart';
import 'package:antassistant/utils/platform/platform.dart';
import 'package:antassistant/utils/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String path = '/login';

  static Widget builder(BuildContext context) => const LoginScreenProvider();

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: responsiveHorizontalEdgeInsets(MediaQuery.of(context)),
          child: _Form(
            username: ModalRoute.of(context)?.settings.arguments as String?,
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  final String? username;

  const _Form({
    Key? key,
    this.username,
  }) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  bool _passwordIsVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // todo: need to think about phone landscape layout
    if (MediaQuery.of(context).isPhone) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginScreenBloc, LoginScreenState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        switch (state.status) {
          case LoginScreenStatus.failure:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).login_screen__error),
                behavior: SnackBarBehavior.floating,
              ),
            );
            break;
          case LoginScreenStatus.success:
            Navigator.of(context).pop(true);
            break;
          default:
            break;
        }
      },
      buildWhen: (prev, curr) => prev.status != curr.status,
      builder: (context, state) => Form(
        child: Builder(
          builder: (context) => AutofillGroup(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  initialValue: widget.username,
                  autofocus: widget.username == null,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.username],
                  decoration: InputDecoration(
                    label: Text(S.of(context).login_form__login_hint),
                  ),
                  onSaved: (username) =>
                      context.read<LoginScreenBloc>().setUsername(username),
                  validator: (username) {
                    if (username == null || username.isEmpty) {
                      return S.of(context).common__required_field;
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  autofocus: widget.username != null,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  autofillHints: const [AutofillHints.password],
                  obscureText: !_passwordIsVisible,
                  onSaved: (password) =>
                      context.read<LoginScreenBloc>().setPassword(password),
                  decoration: InputDecoration(
                    label: Text(S.of(context).login_form__password_hint),
                    suffixIcon: _Visibility(
                      onPressed: () {
                        _passwordIsVisible = !_passwordIsVisible;
                        setState(() {});
                      },
                      visible: _passwordIsVisible,
                    ),
                  ),
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return S.of(context).common__required_field;
                    }
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 56,
                  child: PlatformButton.primary(
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
                        : Text(S.of(context).login_form__login_button),
                  ),
                ),
              ],
            ),
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
        tooltip: S.of(context).login_form__hide_password,
      ),
      secondChild: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.visibility_off),
        tooltip: S.of(context).login_form__show_password,
      ),
      duration: duration,
      crossFadeState:
          visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
