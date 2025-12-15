import 'package:flutter/material.dart';
import 'package:flutter_code_template/feature/auth/view/login_page.dart';

class AppRoutes {
  static const String root = '/';
  static const String auth = '/auth';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case auth:
        return _buildPageRoute(const LoginPage(), settings);

      default:
        return _buildPageRoute(Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))), settings);
    }
  }

  static PageRouteBuilder _buildPageRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      settings: settings,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;
        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(parent: animation, curve: curve);

        return FadeTransition(opacity: tween.animate(curvedAnimation), child: child);
      },
    );
  }
}
