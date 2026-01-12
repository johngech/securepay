import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:securepay/common/widgets.dart';

class LoginActionButton extends StatelessWidget {
  const LoginActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return PrimaryButton(
          label: "Sign In",
          onPressed: form.valid
              ? () => _handleLogin(context, form.value)
              : null,
        );
      },
    );
  }

  void _handleLogin(BuildContext context, Map<String, dynamic> value) {
    context.push("/transaction-dashboard");
    // Logic: ref.read(authProvider.notifier).login(value['email'], value['password']);
  }
}
