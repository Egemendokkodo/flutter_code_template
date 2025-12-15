import 'package:flutter/material.dart';
import 'package:flutter_code_template/core/app/router/app_route.dart';
import 'package:flutter_code_template/core/di/di_providers.dart';

import 'package:flutter_code_template/feature/auth/view/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [loggerProvider, dioProvider, apiClientProvider, userServiceProvider, authViewModelProvider], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Template Project',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: AppRoutes.auth,
      home: LoginPage(),
    );
  }
}
