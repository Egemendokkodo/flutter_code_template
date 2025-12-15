import 'package:flutter/material.dart';
import 'package:flutter_code_template/core/widgets/consumers/common_consumer.dart';
import 'package:flutter_code_template/data/models/user/user_model.dart';
import 'package:flutter_code_template/feature/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter_code_template/feature/auth/widgets/auth_fab.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<LoginViewModel>().fetchUserById(1);
      context.read<LoginViewModel>().fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AuthFab(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonConsumer<LoginViewModel, List<UserModel>>(
            stateSelector: (vm) => vm.usersState,
            builder: (context, user) => Center(child: Text(user.first.email)),

            // Optional widgets
            loadingWidget: const Center(child: CircularProgressIndicator()),
            emptyWidget: const Center(child: Text("No user found")),

            // To show an AlertDialog in case of an error
            errorCallback: (context, message) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Error"),
                  content: Text(message ?? "Unknown error"),
                  actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
                ),
              );
            },

            // errorWidget and errorCallback cannot be used simultaneously
            // errorWidget: (message) => Center(child: Text("Error: $message")),
          ),
          SizedBox(height: 50),
          CommonConsumer<LoginViewModel, UserModel>(
            stateSelector: (vm) => vm.userDetailState,
            builder: (context, user) => Center(child: Text(user.company.name)),

            // Optional widgets
            loadingWidget: const Center(child: CircularProgressIndicator()),
            emptyWidget: const Center(child: Text("No user found")),

            // To show an AlertDialog in case of an error
            errorCallback: (context, message) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Error"),
                  content: Text(message ?? "Unknown error"),
                  actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
                ),
              );
            },

            // errorWidget and errorCallback cannot be used simultaneously
            // errorWidget: (message) => Center(child: Text("Error: $message")),
          ),
        ],
      ),
    );
  }
}
