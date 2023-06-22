import 'package:flutter/material.dart';

import '../handlers/auth_view_handler.dart';
import '../widgets/forms/login_form.dart';
import '../widgets/forms/sign_up_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _authViewState = AuthViewStateHandler();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: _authViewState,
          builder: (context, value, child) {
            return AnimatedCrossFade(
              firstChild: const LoginForm(),
              secondChild: const SignUpForm(),
              crossFadeState: value,
              duration: const Duration(milliseconds: 200),
            );
          },
        ),
      ),
    );
  }
}
