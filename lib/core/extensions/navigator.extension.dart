import 'package:flutter/material.dart';

extension NavigatorExt on BuildContext {
  void back<T extends Object?>([T? result]) {
    return Navigator.pop(this, result);
  }

  Future<T?> toNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed(
      this,
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> toRNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed(
      this,
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> to<T extends Object?>(
    Widget page,
  ) {
    return Navigator.push(this, MaterialPageRoute(builder: (_) => page));
  }

  Future<T?> toR<T extends Object?>(
    Widget page,
  ) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }
}