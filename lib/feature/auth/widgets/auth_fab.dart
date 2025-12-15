import 'package:flutter/material.dart';
import 'package:flutter_code_template/feature/auth/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

class AuthFab extends StatelessWidget {
  const AuthFab({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<LoginViewModel>().fetchUserById(1);
      },
      child: Text("Test different api states"),
    );
  }
}
